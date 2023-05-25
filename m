Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFAB710247
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjEYBU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjEYBU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDDBE6;
        Wed, 24 May 2023 18:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B73B641C0;
        Thu, 25 May 2023 01:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEFCC433EF;
        Thu, 25 May 2023 01:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684977625;
        bh=a+sFiytLmWFLgtD3pXWApwYX6qLc2CEd0ajOsXXioqA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j3zVaJqyzpaKy7t8PPtnTOkfVXEuRR6axKjNtnG0nenSvIoNSCshn+Q/apuv+rHck
         xWcRUAr5NTELSYPDZWib2+qlrWaH83HUHnLegjju1frA/kP+hRKIvOaTZ7+DRT/aph
         p7zEphT7DYCROIaFcpaKPEH2SyDJSBrOKZDnrIBRoog/8rjMBolZhFmmQRw6BnsItf
         4Y6mUmqtwrUHHPX2nRyvMlBpmAlvVwLJ/GRfQOxKP9Zs9N5ddVxA7g3JWMd6x8/SdF
         E6aDyVNBPqgtJ1PKqFRj341WMT25eqF6kwsNKNnE7NziuvOppJxbx4sf/k4wPxdpAl
         EZG70beI8mBbw==
Message-ID: <e6a36b71-045e-4e95-f539-fd88b289e703@kernel.org>
Date:   Thu, 25 May 2023 09:20:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6] f2fs: add async reset zone command support
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Daejun Park <daejun7.park@samsung.com>
Cc:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>
References: <CGME20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5@epcms2p8>
 <20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5@epcms2p8>
 <ZFqWr3sSYMsHtHAC@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZFqWr3sSYMsHtHAC@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/10 2:53, Jaegeuk Kim wrote:
> On 05/08, Daejun Park wrote:
>> v5 -> v6
>> Added trace_f2fs_iostat support for zone reset command.
>>
>> v4 -> v5
>> Added f2fs iostat for zone reset command.
>>
>> v3 -> v4
>> Fixed build error caused by unused function.
>>
>> v2 -> v3
>> Modified arguments to be correct for ftrace parameter.
>> Changed __submit_zone_reset_cmd to void return.
>> Refactored the f2fs_wait_discard_bio function.
>> Fixed code that was previously incorrectly merged.
>>
>> v1 -> v2
>> Changed to apply the optional async reset write pointer by default.
> 
> Don't add the history in the patch description.
> 
>>
>> This patch enables submit reset zone command asynchornously. It helps
>> decrease average latency of write IOs in high utilization scenario by
>> faster checkpointing.
>>
>> Signed-off-by: Daejun Park <daejun7.park@samsung.com>

Except the change log, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
