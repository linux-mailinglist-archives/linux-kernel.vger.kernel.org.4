Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F63723E6E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbjFFJxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbjFFJxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:53:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F573E69
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:53:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DD122F4;
        Tue,  6 Jun 2023 02:54:22 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADF613F587;
        Tue,  6 Jun 2023 02:53:35 -0700 (PDT)
Message-ID: <34b61935-79d1-a5ea-66a0-d86b3dc5c14b@arm.com>
Date:   Tue, 6 Jun 2023 10:53:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 00/13] coresight: Fix CTI module refcount leak by
 making it a helper device
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        quic_jinlmao@quicinc.com, mike.leach@linaro.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230425143542.2305069-1-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230425143542.2305069-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 15:35, James Clark wrote:
> Changes since v5:
> 
>   * Formatting fixes
>   * helper->type != CORESIGHT_DEV_TYPE_HELPER -> !coresight_is_helper()
>   * Remove ect from coresight_dev_type and add a static assert so that
>     it stays in sync with the enum
> 
> ------------------
> 
> Changes since v4:
> 
>   * Update commit message on patch 1
>   * Drop previous change that added lockdep checks to coresight_add_helper()
>     because they are already in mutex_lock(). But keep extra comment.
>   * Check for allocation failure in coresight_add_out_conn()
> 
> ------------------
> 
> Changes since v3:
> 
>   * Put connection loss fix at the beginning so that it can be backported
>   * Replace coresight_find_link_{x}() with coresight_find_out_connection()
>   * Reorder coresight_enable_source() arguments for consistency
>   * Add source and destination reference counts so that two link devices
>     connected together don't clash
>   * Add coresight_is_helper()
>   * Fix overwriting csdev bug in coresight_orphan_match()
>   * Don't clear conns[i]->dest_fwnode in coresight_remove_conns() in case
>     it's used again
>   * Use dev instead of adev->dev for devmem allocation in
>     acpi_coresight_parse_graph() so that it's consistent with DT mode and
>     doesn't cause a warning on free.
>   * Rename coresight_add_helper_mutex() -> coresight_add_helper()
>   * Ensure coresight_mutex isn't already held in coresight_add_helper()
>   * Return new connection from coresight_add_out_conn()
>   * Comment and formatting improvements
> 
> ------------------
> 
> Changes since v2:
> 
>   * Make out_conns array contiguous instead of sparse which simplifies
>     filling and using it. New connections are always added to the end
>   * Store pointers to individual connection objects so that they can be
>     shared between inputs and outputs
>   * Fix an existing bug where connection info was lost when unloading a
>     device
>   * Simplify connection fixup functions. Now the orphan mechanism is used
>     for inputs in the same way as outputs to guarantee that all
>     connections have both an input and an output set
>   * Use input connections to disconnect devices on unload instead of
>     iterating through them all
>   * Make refcount a property of the connection rather than use it's own
>     array based on the number of inputs and outputs
>   * Fix a bug in v2 where helpers attached to the source device weren't
>     disabled because coresight-etm-perf.c was making a raw call to
>     disable rather than using a helper.
>   * Change names of connection members to make direction explicit now
>     that the connection is shared between input and outputs
>     
> ------------------
> 
> Changes since v1:
> 
>   * Don't dereference handle in tmc_etr_get_buffer() when not in perf mode.
>   * Fix some W=1 warnings
>   * Add a commit to rename child/output in terms of local/remote
> 
> -------------------
> 
> Currently there is a refcount leak in CTI when using system wide mode
> or tracing multithreaded applications. See the last commit for a
> reproducer. This prevents the module from being unloaded.
> 
> Historically there have been a few issues and fixes attempted around
> here which have resulted in some extra logic and a member to keep
> track of CTI being enabled 'struct coresight_device->ect_enabled'.
> The fix in commit 665c157e0204 ("coresight: cti: Fix hang in
> cti_disable_hw()") was also related to CTI having its own
> enable/disable path which came later than other devices.
> 
> If we make CTI a helper device and enable helper devices adjacent to
> the path we get very similar enable/disable behavior to now, but with
> more reuse of the existing reference counting logic in the coresight
> core code. This also affects CATU which can have a little bit of
> its hard coded enable/disable code removed.
> 
> Enabling CATU on the generic path does require that input connections
> are tracked so that it can get its associated ETR buffer.
> 
> Applies to coresight/next (18996a113f256) but everything except the
> first fixes commit requires the realloc_array patch here [1].
> 
> Also available in full here [2].
> 
> [1]: https://lore.kernel.org/linux-arm-kernel/20230320145710.1120469-1-james.clark@arm.com/
> [2]: https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-cs-cti-module-refcount-fix-v6

Queued to coresight/next


[01] https://git.kernel.org/coresight/c/c45b2835e7b2
[02] https://git.kernel.org/coresight/c/9fa3682869d4
[03] https://git.kernel.org/coresight/c/704faaf4e33c
[04] https://git.kernel.org/coresight/c/81d0ea763d8a
[05] https://git.kernel.org/coresight/c/d49c9cf15f89
[06] https://git.kernel.org/coresight/c/3d4ff657e454
[07] https://git.kernel.org/coresight/c/4e8fe7e5c3a5
[08] https://git.kernel.org/coresight/c/102162dbac89
[09] https://git.kernel.org/coresight/c/e3f4e68797a9
[10] https://git.kernel.org/coresight/c/ae7f2b5a7b56
[11] https://git.kernel.org/coresight/c/296b01fd106e
[12] https://git.kernel.org/coresight/c/6148652807ba
[13] https://git.kernel.org/coresight/c/1b5b1646e63d



Thanks
Suzuki

