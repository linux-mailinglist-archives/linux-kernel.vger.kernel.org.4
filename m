Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C878274A0BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGFPSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjGFPSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:18:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1351997
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B36536023A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB965C433C8;
        Thu,  6 Jul 2023 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688656722;
        bh=PbZ1+K7/ycQgt3p7bChWS7NewJZAPs5Z0ueIwPNsb/s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iTfZ/YjXi6ibhTuFaou9mv3Q9Kov1pZMwM+Ah+ObPeBtVH0DeZtYT4ZZBo/GS6MX6
         55LMdthnWRAKaYgtwbGIYUfpkxPIEjqE+Ynq64XMTkjNw1GYHlP4Gs0OorGMA8ffv6
         lXf0UIexh9jJLRGRhxB2Y8avLMD0Wbkx6sAJqhI2kNVXaFmF7i6CkkzBmBLRfbD5e3
         /fpXmbpq1h8cQKEP2C+guqrcYjp/609KDXiGoITkP4q5rADtXfVnsAu9u6QYiGOxqn
         sV3aEid5TAtffJvYVvje/Z96rQEaEJV+lOsdJkIH2SwqRMh9Mc2N13Scmepb69mvi/
         PsSQaZ1gnNUzg==
Message-ID: <2ca3892e-a018-37e1-5a3d-288e6af2ec4d@kernel.org>
Date:   Thu, 6 Jul 2023 10:18:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0hdIGZpcm13YXJlOiBzdHJh?=
 =?UTF-8?Q?tix10-svc=3a_Fix_an_NULL_vs_IS=5fERR=28=29_bug_in_svc=5fcreate=5f?=
 =?UTF-8?Q?memory=5fpool=28=29?=
Content-Language: en-US
To:     =?UTF-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
References: <20230704082706.1721-1-machel@vivo.com>
 <fe780326-2150-a3e6-e451-ea82be65e0cf@web.de>
 <daa12e00-1d01-45d0-89c8-03ff94fa3399@kadam.mountain>
 <SG2PR06MB3743AC289C8C124CA57C77DABD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
 <fe812000-c5bf-4510-a3a9-76684a59ecc9@kadam.mountain>
 <SG2PR06MB3743DD3C50017612CF3BE38ABD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <SG2PR06MB3743DD3C50017612CF3BE38ABD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/23 03:56, 王明-软件底层技术部 wrote:
> I see. Thank you
> 
> -----邮件原件-----
> 发件人: Dan Carpenter <dan.carpenter@linaro.org>
> 发送时间: 2023年7月6日 16:52
> 收件人: 王明-软件底层技术部 <machel@vivo.com>
> 抄送: Dinh Nguyen <dinguyen@kernel.org>; LKML <linux-kernel@vger.kernel.org>; opensource.kernel <opensource.kernel@vivo.com>
> 主题: Re: 回复: [PATCH] firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in svc_create_memory_pool()
> 
> On Thu, Jul 06, 2023 at 08:44:39AM +0000, 王明-软件底层技术部 wrote:
>> Thank you Dan carpenter.
>> This patch has been submitted for a long time, but I have not heard
>> back from the maintainer, and I am confused whether I need to send it
>> again

Looks like you sent an original patch on July 1st, then you sent another 
patch on July 4th. In the future, please take Dan's advice on 2 weeks 
and if you do need to resend you can add a 'RESEND' to the subject line, 
or just reply with a ping to the original patch. I was on a short leave. 
I'll take your patch next week with the edits from Dan's comments.

Thanks,
Dinh


