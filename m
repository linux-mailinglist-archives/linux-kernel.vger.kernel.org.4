Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7496C5F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjCWGTR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Mar 2023 02:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCWGTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:19:15 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37DB1A64D;
        Wed, 22 Mar 2023 23:19:13 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso1003007pjb.3;
        Wed, 22 Mar 2023 23:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679552353;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg4sx6R0VBac6XSSrcISFuaXjt8rrPV7uR6bz6tbY6s=;
        b=D6ZXn2gRlEIzh+kppVCWywkg3dzcv+oGX1cwRv5SEY9ICgmrqiU3YnDirGbCi5r7WB
         NdYJncJhdo7sXQJs7SvQoJKJEuuxTM/8shQtjdfG1vDX6ZXGzQzy7PhJz/oGvLzcwpe5
         6CTJ3pDLjeCbEu9c5UgixALwJqtyQUSlSWZM5inFifJc3QQnMi25kFNIYi/wsaYk0eiH
         byU61Bl9hZE5OnDAHcAuPV5HLcTXaQ5mi63Vpl7d34aZYSxDKZSvNTenpR4yykEef+XO
         iD9ftWhxN1MIpRKHMhwrKqp1PS7jqRijSrepBtLjVggzC7Z4uP7T5M8wphmKhG/upwiI
         aWRg==
X-Gm-Message-State: AAQBX9fg7bRXqxyA7gg9XqBIy9Tit1BYkafFl/AgEcswpWQ1BbcVxHNX
        fNKIBWk8QZ3TbJTTq+n2YCI=
X-Google-Smtp-Source: AKy350ZfLlt2RZbdaru7nksokyP6vjlLtsS5a0TUC9FsvURrPs0jHKh397eHXa+Ac7feSV3OmeDHfw==
X-Received: by 2002:a17:90b:1c84:b0:23b:4438:e9ee with SMTP id oo4-20020a17090b1c8400b0023b4438e9eemr4632033pjb.12.1679552353095;
        Wed, 22 Mar 2023 23:19:13 -0700 (PDT)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b0023d0c2f39f2sm544134pjb.19.2023.03.22.23.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 23:19:12 -0700 (PDT)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sunke <sunke@kylinos.cn>, Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [PATCH -next] usb: xhci: do not free an empty cmd ring
Date:   Thu, 23 Mar 2023 14:19:09 +0800
Message-Id: <02ea8a2d-ecfd-d693-65b3-26285e3f51f1@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZBtXM3oXeOclQNK0@kroah.com>
References: <20230320042223.676505-1-xiehongyu1@kylinos.cn> <ZBtXM3oXeOclQNK0@kroah.com>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Thunderbird/102.8.0
Content-Language: en-US
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0; attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc:    imap://xiehongyu1%40kylinos.cn@imap.kylinos.cn/Sent
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi greg,

在 2023/3/23 03:29, Greg KH 写道:
> On Mon, Mar 20, 2023 at 12:22:23PM +0800, Hongyu Xie wrote:
>> It was first found on HUAWEI Kirin 9006C platform with a builtin xhci
>> controller during stress cycle test(stress-ng, glmark2, x11perf, S4...).
>>
>> phase one:
>> [26788.706878] PM: dpm_run_callback(): platform_pm_thaw+0x0/0x68 returns -12
>> [26788.706878] PM: Device xhci-hcd.1.auto failed to thaw async: error -12
>> ...
>> phase two:
>> [28650.583496] [2023:01:19 04:43:29]Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
>> ...
>> [28650.583526] user pgtable: 4k pages, 39-bit VAs, pgdp=000000027862a000
>> [28650.583557] [0000000000000028] pgd=0000000000000000
>> ...
>> [28650.583587] pc : xhci_suspend+0x154/0x5b0
>> [28650.583618] lr : xhci_suspend+0x148/0x5b0
>> [28650.583618] sp : ffffffc01c7ebbd0
>> [28650.583618] x29: ffffffc01c7ebbd0 x28: ffffffec834d0000
>> [28650.583618] x27: ffffffc0106a3cc8 x26: ffffffb2c540c848
>> [28650.583618] x25: 0000000000000000 x24: ffffffec82ee30b0
>> [28650.583618] x23: ffffffb43b31c2f8 x22: 0000000000000000
>> [28650.583618] x21: 0000000000000000 x20: ffffffb43b31c000
>> [28650.583648] x19: ffffffb43b31c2a8 x18: 0000000000000001
>> [28650.583648] x17: 0000000000000803 x16: 00000000fffffffe
>> [28650.583648] x15: 0000000000001000 x14: ffffffb150b67e00
>> [28650.583648] x13: 00000000f0000000 x12: 0000000000000001
>> [28650.583648] x11: 0000000000000000 x10: 0000000000000a80
>> [28650.583648] x9 : ffffffc01c7eba00 x8 : ffffffb43ad10ae0
>> [28650.583648] x7 : ffffffb84cd98dc0 x6 : 0000000cceb6a101
>> [28650.583679] x5 : 00ffffffffffffff x4 : 0000000000000001
>> [28650.583679] x3 : 0000000000000011 x2 : 0000000000e2cfa8
>> [28650.583679] x1 : 00000000823535e1 x0 : 0000000000000000
>>
>> gdb:
>> (gdb) l *(xhci_suspend+0x154)
>> 0xffffffc010b6cd44 is in xhci_suspend (/.../drivers/usb/host/xhci.c:854).
>> 849	{
>> 850		struct xhci_ring *ring;
>> 851		struct xhci_segment *seg;
>> 852
>> 853		ring = xhci->cmd_ring;
>> 854		seg = ring->deq_seg;
>> (gdb) disassemble 0xffffffc010b6cd44
>> ...
>> 0xffffffc010b6cd40 <+336>:	ldr	x22, [x19, #160]
>> 0xffffffc010b6cd44 <+340>:	ldr	x20, [x22, #40]
>> 0xffffffc010b6cd48 <+344>:	mov	w1, #0x0                   	// #0
>>
>> During phase one, platform_pm_thaw called xhci_plat_resume which called
>> xhci_resume. The rest possible calling routine might be
>> xhci_resume->xhci_init->xhci_mem_init, and xhci->cmd_ring was cleaned in
>> xhci_mem_cleanup before xhci_mem_init returned -ENOMEM.
>>
>> During phase two, systemd was tring to hibernate again and called
>> xhci_suspend, then xhci_clear_command_ring dereferenced xhci->cmd_ring
>> which was already NULL.
>>
>> So if xhci->cmd_ring is NULL, xhci_clear_command_ring just return.
>>
>> Co-developed-by: sunke <sunke@kylinos.cn>
>> Signed-off-by: sunke <sunke@kylinos.cn>
>> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
>> ---
>>   drivers/usb/host/xhci.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index 6183ce8574b1..8b79ad2955e5 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -919,6 +919,10 @@ static void xhci_clear_command_ring(struct xhci_hcd *xhci)
>>   {
>>   	struct xhci_ring *ring;
>>   	struct xhci_segment *seg;
>> +	if (!xhci->cmd_ring) {
>> +		xhci_err(xhci, "Empty cmd ring");
> 
> Why is this being told to userspace?  What can it do about it?
Can do nothing about it. But it's always good to know what was wrong.
> 
>> +		return;
> 
> Not returning an error?
Return -EINVAL to skip the rest of xhci_suspend? It might break kabi.
> 
>> +	}
>>   
> 
> Please always use checkpatch.pl when sending patches out so that
> maintainers have to ask you to use checkpatch.pl.
I did, no warning and no error.
> 
> Also, what commit does this fix?  Does this need to go to stable trees?
It would be 898213200cba. Yes. I'll fix it in v2.
> 
> But wait, this feels wrong, what can keep this variable from being set
> to NULL right after you check it?  Where it the lock involved?
xhci_clear_command_ring only exits in xhci_suspend. cmd_ring only sets
to NULL in xhci_mem_cleanup, which called by xhci_mem_init, xhci_stop,
xhci_resume.
> 
> thanks,
> 
> greg k-h
thanks,

Hongyu Xie

