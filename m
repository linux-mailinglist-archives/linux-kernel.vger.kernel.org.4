Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBD5722D24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjFEQ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjFEQ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A6BED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685984344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y50p/0+oWHhhFYPgth0jR3BiuBMuj4lSU+BTc9jCgts=;
        b=dJLL8nBS5yGKqEXH50bJv3x229EOhgdIqVjKhEBahOah8U2VABUojr/o0bXHHsjiiGSe/b
        0htnMdYxABDJ2iSIesAU/PPsFRLSZP0ZLTCgb8Bi4GWmDj08ZVINM7PpeE9sj5noc9ZW/O
        dL3nl8+nRKnQkI0JwzKizOhC44Sdk44=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96--o8xIUXZNsuVdFk07MOqcw-1; Mon, 05 Jun 2023 12:59:00 -0400
X-MC-Unique: -o8xIUXZNsuVdFk07MOqcw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75b1351b76eso672263485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 09:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685984340; x=1688576340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y50p/0+oWHhhFYPgth0jR3BiuBMuj4lSU+BTc9jCgts=;
        b=fUjveMm6n4aBTwVwmsh+3/F/B/gHt16C08vmYUCRknMfO0MA8qExnXg8JSofsoUoWe
         nttEzbxMEgxzlC6MVsR3KS0a+fmZsbUwl46MEYBGhIGJ0O3jP84zA7HDwezAK9hQRcGU
         OWW3LhQfxMWKKeEpptabkzGdMrCvzKgezWjNFoeFYtPwRikyijGH/vauYYZaaNCH+pm2
         CUzzjKq2q0SIGfVjhLmQMKhFuT+IUQUdu+ixH8PrpzGWDPyzX6NS4ycRYEkEzHE1spYC
         0ZEL2tRnNQHf30G+HbDmGJTBBCURHBPkD3Telq8GAzwFaL3Ry2zgfCTZ++yBZI8nN0dp
         2QWA==
X-Gm-Message-State: AC+VfDzpdgwFYZASylb+j2LIs5dqTV3D9RnMTrgxoWO1apZ90nBpOIN7
        YxDC3ExS5/gFbROgeACMd//aV+xAQkmI8CQ0wp9MVhjdAY6JLrmiU076jpIrY6esnWM5nPDLPWT
        splYsUtN/gMXocL2n6tr3d7s=
X-Received: by 2002:a05:620a:880f:b0:75e:2a27:2543 with SMTP id qj15-20020a05620a880f00b0075e2a272543mr431015qkn.15.1685984340032;
        Mon, 05 Jun 2023 09:59:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7XKn25F/+47ap22TpytuchRa8fmxTRyMtZwMCrtzmwBQq2cuxamoKOIdEfGkOGAgCXeQ7viw==
X-Received: by 2002:a05:620a:880f:b0:75e:2a27:2543 with SMTP id qj15-20020a05620a880f00b0075e2a272543mr431004qkn.15.1685984339796;
        Mon, 05 Jun 2023 09:58:59 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-28-201.cust.vodafonedsl.it. [2.34.28.201])
        by smtp.gmail.com with ESMTPSA id f16-20020a05620a12f000b0075ca4cd03d4sm4308552qkl.64.2023.06.05.09.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 09:58:59 -0700 (PDT)
Message-ID: <d1ef2f9a-f416-e7d6-7481-d81c1941702e@redhat.com>
Date:   Mon, 5 Jun 2023 18:58:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v6 3/4] fpga: add an initial KUnit suite for the FPGA
 Region
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230531095405.342080-1-marpagan@redhat.com>
 <20230531095405.342080-4-marpagan@redhat.com>
 <ZHuQc7WfN1zKOeTE@yilunxu-OptiPlex-7050>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZHuQc7WfN1zKOeTE@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-03 21:11, Xu Yilun wrote:
> On 2023-05-31 at 11:54:04 +0200, Marco Pagani wrote:
>> The suite tests the programming of an FPGA Region with a Bridge
>> and the function for finding a particular Region.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/tests/fpga-region-test.c | 186 ++++++++++++++++++++++++++
>>  1 file changed, 186 insertions(+)
>>  create mode 100644 drivers/fpga/tests/fpga-region-test.c

[...]

 
> Maybe better just put all tests in one module, and have unified
> fake_mgr_ops/mgr_stats/fake_bridge_ops/bridge_stats across all tests.
> 
> In previous thread, I said I'm good to the self-contained test module
> but I didn't actually follow the idea. Sorry for that.
> 
> The concern is why in this region test, the write_count and only the
> write_count is taken care of.
> 
> Although fpga_mgr_load() test covers all mgr_ops, but does that
> means these ops are still good for more complex case like
> fpga_region_program_fpga()? And there is no guarantee
> fpga_region_program_fpga() would always call mgr_ops the same way
> as fpga_mgr_load() in future.
> 
> Similar for fpga_bridge. Maybe a complete setup for fpga_region is
> still necessary.

I think that putting all tests in a single module (like in previous
versions) goes against the principles of unit testing, making the
code more similar to an integration test.

Unit tests should be focused on a single behavior. The programming
test case included in the Region's suite should test only the behavior
of the Region itself. Specifically, that fpga_region_program_fpga() calls
get_bridges(), to get and control bridges, and then the Manager for the
actual programming.

The programming sequence itself is outside the responsibilities of the
Region, and its correctness is already ensured by the Manager suite.
Similarly, the correctness of the Bridge's methods used by the Region
for getting and controlling multiple bridges is already ensured by the
Bridge test suite.

For this reason, the Manager and Bridge fakes used in the Region suite
implement only the minimal set of operations necessary to ensure the
correctness of the Region's behavior. If I used a "full" Manager (and
tested all mgr_ops), then the test case would have become an integration
test rather than a unit test for the Region.
> BTW: I like the way that fake drivers are removed. Looks much straight
> forward.

I appreciate that.
 
> Thanks,
> Yilun
>

Thanks,
Marco

[...]

