Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6976BA8A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjCOHEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjCOHEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:04:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7777414EA6;
        Wed, 15 Mar 2023 00:04:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E876B81BC2;
        Wed, 15 Mar 2023 07:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6189C4339B;
        Wed, 15 Mar 2023 07:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678863860;
        bh=HfKsxNuC/G+cNO1kdYjw4g4ql2bpJRqyU+5exegLZAE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HhIGD/8EEE+/ipLQqCQ0FZYEXlz9uG2zAa/q19E9JHtLhDsPY26uhoG5SrqHGbATL
         vqCY9O6MJ+D0jpJZ4fp7yFgjK9Tns/EqdpPTs0EjZ2reIRkCOSUoQ/fOUXX1dLsXyR
         yeOUV69/3KZ5rLLuOAra82jS3Z0KDIvzc8a3xlSZd9BtkZwB+/sJ72o+7bWmFjtKcH
         ihc8NUUqTOzNteCmkVeRRk0GjjyLV91H+fWj+NxLROSvOuY/smWgy71L+Nlq+H6kZG
         rvn0Ecq5N2hK+Yy7y3FkRyKmLlNxfscq6/xdWh46PrghgJWOvtXcgMPcIcENPN16pz
         Ao1lt+CtT71QQ==
Message-ID: <cdfe3d41-5ea4-c6a8-fbab-4920d08c6303@kernel.org>
Date:   Wed, 15 Mar 2023 08:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] Fix buffer overrun in HID-SENSOR name string
To:     Todd Brandt <todd.e.brandt@intel.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     todd.e.brandt@linux.intel.com, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, jikos@kernel.org, p.jungkamp@gmx.net
References: <20230313220653.3996-1-todd.e.brandt@intel.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230313220653.3996-1-todd.e.brandt@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 23:06, Todd Brandt wrote:
> On some platforms there are some platform devices created with
> invalid names. For example: "HID-SENSOR-INT-020b?.39.auto" instead
> of "HID-SENSOR-INT-020b.39.auto"
> 
> This string include some invalid characters, hence it will fail to
> properly load the driver which will handle this custom sensor. Also
> it is a problem for some user space tools, which parse the device
> names from ftrace and dmesg.
> 
> This is because the string, real_usage, is not NULL terminated and
> printed with %s to form device name.
> 
> To address this, we initialize the real_usage string with 0s.
> 
> Philipp Jungkamp created this fix, I'm simply submitting it. I've
> verified it fixes bugzilla issue 217169
> 
> Reported-and-tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>

SoB denotes that you reported this and tested. Otherwise shall we start
adding Reported and Tested tags to all of our commits?


Best regards,
Krzysztof

