Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845A569464E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjBMMvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBMMvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:51:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA887D89
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676292616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PgLQ6zOF160defT8Ds9P+E2M/1VCvo9hFksAoPbKUJE=;
        b=Ic0070F7tMpAIoWqIk/5LrttLPtDGJKApDrBLEyX6+yU4oyB8dYvOTD4neSmpxbTGrT1CY
        wLpDTPqfQK8i32GWY4xUDTCUXMlPYTSVyCR6MsSgOD3LRpPii5sMIN/1aw0TOQeTy+SmyE
        tUEjt0Eik2VF8NY9ryPbTjNPsFGH+Vs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-gWV5vzs1NHGGbQFPG0OXmA-1; Mon, 13 Feb 2023 07:50:14 -0500
X-MC-Unique: gWV5vzs1NHGGbQFPG0OXmA-1
Received: by mail-ed1-f69.google.com with SMTP id z19-20020a05640235d300b004aaca83cd87so7560594edc.20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgLQ6zOF160defT8Ds9P+E2M/1VCvo9hFksAoPbKUJE=;
        b=rbGpCOh9AQ7jBFicnshnW7g8dSn3M43RnPmTgT/sjB9SVV/pyqMM6RK5FOv5FptyFq
         MNt8W47UhcTCG1fGPkOCTXyETjBTHvQZoZeAYICS0lsjbZ/9Bg1ioigKFtLW/Y5N25dJ
         QDBESHlGdgxLhuE8sClr3fQVrkN91QLgwhdp+C1VKPHM7P1y5MYi5nEiv7nldZ9yy3BQ
         Lnd+RvjQDRWmEMjarEYiBrnMQsRom4IOJcSI5ycWjVxVSvZQKhgnWeJG1bnfTACAnOVT
         dlu/ue4XveLObGnr+JEQtmFQHRA2OEhKF/7iELEPC3e5LM5jiBCvTNkiR8o0hTWy4tjE
         HJIw==
X-Gm-Message-State: AO0yUKXOulqoU0LFSfH/War4HYHErUFtYzZKJPQGB0gCTGI6++a/7tFL
        hFTv0D3MRA7TgEXdlarqxo2WghbI+7Cb1zLoySx/4m5VpvbNoYWl66NjNC1CGWIBcaT84G5Kujm
        yyEiIXwUoTaEwNmcLFG3+DSCr
X-Received: by 2002:a17:907:7ea8:b0:8b1:15ab:f4cd with SMTP id qb40-20020a1709077ea800b008b115abf4cdmr2485956ejc.53.1676292613797;
        Mon, 13 Feb 2023 04:50:13 -0800 (PST)
X-Google-Smtp-Source: AK7set988aY5h338ir+/KHdB4LqQr3BYrvN4X1DsZMqEr4WXANn9H4WIA5oj3gjPEwtYrkusriJ/eg==
X-Received: by 2002:a17:907:7ea8:b0:8b1:15ab:f4cd with SMTP id qb40-20020a1709077ea800b008b115abf4cdmr2485946ejc.53.1676292613620;
        Mon, 13 Feb 2023 04:50:13 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:4783:a68:c1ee:15c5? ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
        by smtp.googlemail.com with ESMTPSA id g22-20020a17090670d600b008b0ff9c1ea8sm2369922ejk.56.2023.02.13.04.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:50:13 -0800 (PST)
Message-ID: <88a89319-a71e-fa90-0dbb-00cf8a549380@redhat.com>
Date:   Mon, 13 Feb 2023 13:50:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: "KVM: x86/mmu: Overhaul TDP MMU zapping and flushing" breaks SVM
 on Hyper-V
Content-Language: en-US
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianyu Lan <ltykernel@gmail.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
References: <43980946-7bbf-dcef-7e40-af904c456250@linux.microsoft.com>
 <Y+aQyFJt9Tn2PJnC@google.com>
 <9a046de1-8085-3df4-94cd-39bb893c8c9a@linux.microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <9a046de1-8085-3df4-94cd-39bb893c8c9a@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/13/23 13:44, Jeremi Piotrowski wrote:
> Just built a kernel from that tree, and it displays the same behavior. The problem
> is not that the addresses are wrong, but that the flushes are issued at the wrong
> time now. At least for what "enlightened NPT TLB flush" requires.

It is not clear to me why HvCallFluyshGuestPhysicalAddressSpace or 
HvCallFlushGuestPhysicalAddressList would have stricter requirements 
than a "regular" TLB shootdown using INVEPT.

Can you clarify what you mean by wrong time, preferrably with some kind 
of sequence of events?

That is, something like

CPU 0	Modify EPT from ... to ...
CPU 0	call_rcu() to free page table
CPU 1	... which is invalid because ...
CPU 0	HvCallFlushGuestPhysicalAddressSpace

Paolo

