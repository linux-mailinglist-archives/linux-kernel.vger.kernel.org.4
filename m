Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73885FE0B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiJMSNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiJMSM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:12:28 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C0417C557;
        Thu, 13 Oct 2022 11:09:04 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id F007D3C0F59;
        Thu, 13 Oct 2022 17:57:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 624E23C1553;
        Thu, 13 Oct 2022 17:57:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665683879; a=rsa-sha256;
        cv=none;
        b=U6onYoy7XR3J70lkTfxIAs1S6IdqvIVSzOnedy///kNItP05shtxMslPHncOtl07x9wG6b
        kURGNBd5ttmALqy0FCbdO9RNerXZ9fsYE21DKr2oDAIbrQFio+sdC5hsCNMjDql6GpD38Y
        9vptqxzkyjibN+a0DM5/kovzccmTEP/wOSETvqNxp2mZQI9gu3AnDC28UYyFVhhIVKK+V2
        fEoANmDDeAiF0d1T6ASpl9Y0/GMS6bmI5UEvEaS6MiB/iHKt83proMVjKwTz4MUB+sJfLH
        9Fgp3V3NXTk72R+hwgY/9zZsEwuE1LVRJFHEItwKQtMJpxgYxFyyjjKyksNgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665683879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=f3s8sWc25gq+eWj1L9Vy+NVlfDYvpw/32DiXoWykXFw=;
        b=6PU3teq0ycQeqA+/PkchNnBuH863VS2HaZfyNB34/EUPon9TKDkqck6rD+GTShBjpyHWrM
        gzbO3+wgTOWZkxCoaA78NlDwH/01MQFD6Z6psgl7cQw6KIFQ2AqGfyB1anRm9QiQjfB7P1
        mqNXK2LiRNJ6Me5TVu9UqIAwYKeidk+UUULxL9aCiwjPn1iA2pn09clk5JKzTH3reLS+hp
        1Qerz0dyHqiAgZtxwf+KQ6ool/Hsf7lHlhHMPrUc+2t6EDIBkBjDHmc1YEQ+Oqx76AmWd9
        B+Q7YuMb9e06k9HhB0AdwRS0qnsiZM2xqDEaiO7AqizlItqZMGsHsbStU1splQ==
ARC-Authentication-Results: i=1;
        rspamd-7c485dd8cf-fm5wb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Print-Cooperative: 3446745c4866d4cb_1665683879696_2429676045
X-MC-Loop-Signature: 1665683879696:1358752125
X-MC-Ingress-Time: 1665683879696
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.234.207 (trex/6.7.1);
        Thu, 13 Oct 2022 17:57:59 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4MpHLG4kk8z4h;
        Thu, 13 Oct 2022 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665683879;
        bh=Cp5oOM4plEZlxFu/1TUngUErBCLDH5+1REIPYMGr+ls=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=gMqX1IfNm+/8OuopssrEqgr6X/AzhoG47GxacjrHLA3iFXG/zQ2RYjK8RMizeliVu
         mCYb7o4kNYPb0AbI3CYIowhEAOAevuPR6O++bdw5dHk/AVKUaKprYF0otM+hdledj2
         5JTtimNlKW12huWB5hgrfc0CQhdaiBsKIFr8zMZs9SC+QGQtP+9V9522JerI3ujNoQ
         RBQw6rCPOEg2KK5x2/PpUFPONbkMO+Ve2V4DSlvFn8s5+vugvwM/lxjA7cG6tWiufM
         Xw9AnJwcqHxFp2iXa0eLTRUNIPmFFqBy8BYMJ19r5M2LVu1T103jDMj9DcJEFCK/Ix
         WDbp5WLdfbwBQ==
Date:   Thu, 13 Oct 2022 10:37:03 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: Add generic MSI/MSI-X interrupt support
Message-ID: <20221013173703.th54drzlafvj74oo@offworld>
References: <20221012180432.473373-1-dave@stgolabs.net>
 <20221013131913.0000038b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221013131913.0000038b@huawei.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for having a look.

On Thu, 13 Oct 2022, Jonathan Cameron wrote:

>> +struct cxl_irq_cap {
>> +	const char *name;
>> +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
>
>For the CPMU case I need to walk the register locator dvsec block so need
>the callback to take the pci_dev not the cxl_dev_state.

Hmm ok, however maybe I'm missing something, but given a pdev, do we have a
way to get back to the cxlds?

...

>>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  {
>>  	struct cxl_register_map map;
>> @@ -498,6 +558,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	if (IS_ERR(cxlmd))
>>  		return PTR_ERR(cxlmd);
>>
>> +	/* TODO: When there are users, this return value must be checked */
>> +	cxl_pci_alloc_irq_vectors(cxlds);
>> +
>
>Gut feeling is this will end up moving ahead of any of the sub device creation
>because many of them end up needing interrupts.
>
>Also check response from the start - can't see a reason to not do so as we
>won't be registering any at all if no callbacks provided.
>
>So I'd move it above the devm_cxl_add_memdev() call.

Will do. In addition, are you ok with grouping the irq setup for each cxl
feature/component, ie:

if (cxl_pci_alloc_irq_vectors(cxlds) > 0) {
    cxl_setup_mbox_irq();
    cxl_setup_events_irq();
    cxl_setup_pmu_irq();
}

I ask mostly from the mailbox perspective, in that we already have
a mbox setup call and can certainly understand if people would prefer
it there, but I tend to prefer the above (logically wrt irqs).

Thanks,
Davidlohr
