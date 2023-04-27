Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650C56F0A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbjD0Qxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjD0Qx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:53:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E31B5273B;
        Thu, 27 Apr 2023 09:53:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 648B92F4;
        Thu, 27 Apr 2023 09:54:09 -0700 (PDT)
Received: from [10.57.82.122] (unknown [10.57.82.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED5183F587;
        Thu, 27 Apr 2023 09:53:21 -0700 (PDT)
Message-ID: <7e2eaf1f-369a-d664-1011-3da6efb382a3@arm.com>
Date:   Thu, 27 Apr 2023 17:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/11] Add support to configure TPDM DSB subunit
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 10:00, Tao Zhang wrote:
> Introduction of TPDM DSB subunit
> DSB subunit is responsible for creating a dataset element, and is also
> optionally responsible for packing it to fit multiple elements on a
> single ATB transfer if possible in the configuration. The TPDM Core
> Datapath requests timestamps be stored by the TPDA and then delivering
> ATB sized data (depending on ATB width and element size, this could
> be smaller or larger than a dataset element) to the ATB Mast FSM.
> 
> The DSB subunit must be configured prior to enablement. This series
> adds support for TPDM to configure the configure DSB subunit.
> 
> Once this series patches are applied properly, the new tpdm nodes for
> should be observed at the tpdm path /sys/bus/coresight/devices/tpdm*
> which supports DSB subunit.
> e.g.
> /sys/devices/platform/soc@0/69d0000.tpdm/tpdm0#ls -l | grep dsb
> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_edge_ctrl
> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_edge_ctrl_mask
> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_mode
> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_patt_mask
> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_patt_ts
> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_patt_type
> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_patt_val
> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_trig_patt_mask
> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_trig_patt_val
> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_trig_ts
> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_trig_type
> 
> We can use the commands are similar to the below to configure the
> TPDMs which support DSB subunit. Enable coresight sink first.
> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/tpdm0/reset
> echo 0x3 0x3 0x1 > /sys/bus/coresight/devices/tpdm0/dsb_edge_ctrl_mask
> echo 0x6d 0x6d 0 > /sys/bus/coresight/devices/tpdm0/dsb_edge_ctrl
> echo 1 > /sys/bus/coresight/devices/tpdm0/dsb_patt_ts
> echo 1 > /sys/bus/coresight/devices/tpdm0/dsb_patt_type
> echo 0 > /sys/bus/coresight/devices/tpdm0/dsb_trig_ts
> echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm0/dsb_patt_mask
> echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm0/dsb_trig_patt_val
> 
> This patch series depends on patch series "[PATCH v2 0/9] coresight:
> Fix CTI module refcount leak by making it a helper device"
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20230425143542.2305069-14-james.clark@arm.com/

There is v6 available for the above and there may be changes in the data
structures. But the series is stable now, and may be you could cordinate
with James and repost the series at rc1 ?

Suzuki

