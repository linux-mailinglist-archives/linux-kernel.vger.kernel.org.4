Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB206873C8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjBBDZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjBBDZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:25:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8302C2A98B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675308305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iY/OQt8yhAuJl9finL5LdlRPRN18tAZGyT7vixhBhhY=;
        b=Mc/iEoFepQ/Ktm3t1JiU2ezc9tZy57e1U5O0UlgFQ/kRFcUYXkVfbdQaBASoi72vzB7kAJ
        7NqFzUHL72+gJ/wmn5svjBUdD92HGs8z6Nk4/OB4AxpmYiWdpl8Fo5406KUg7xP3W5pCpw
        gWBbE8V/76Ot8E+Y4NHYMRCZ1TCaa2k=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-LX_jsXVANCKDtE5JRu-NWw-1; Wed, 01 Feb 2023 22:25:03 -0500
X-MC-Unique: LX_jsXVANCKDtE5JRu-NWw-1
Received: by mail-pf1-f197.google.com with SMTP id s4-20020a056a00194400b0058d9b9fecb6so288067pfk.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 19:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iY/OQt8yhAuJl9finL5LdlRPRN18tAZGyT7vixhBhhY=;
        b=kYFK1NlunSe/Yjg97Erd2tB+MErJfsZVhoNleznUgqDSTspS6MWHUmR9EjPV2s37MU
         pOQtWIz/9cJ3CHU0OFrWnBlsws2UcvDKVr36abbivaY2ZWtFgxt7xeKDQ6eSxt/I+yUl
         d+oxcmvu6wgbVDzJnBOSdj7FtX/dlvzBC3Lt+YZqVaBcJXbCLjsyeZBrXfB50JwTbdmv
         asttLWcAGRlAuqTXJ4k301m2OrxHLCliYRuTGwFcmSasEdO+ycGCR2JHXydO+fi0VmWl
         8tgOOXb1B9ZosZ+rf4CXOSqWkab+WMFj1MUogR+i2aHzcmePQauDlid4uU35XlsqF1uH
         7VKA==
X-Gm-Message-State: AO0yUKVwIzR02DTwJCaTX7sMgsisd+2RXbl8yBsVnJFcSZv99npDM9AL
        yX865T6wUkwHgjSDpOOyRufx2kKMRk1H6iobs6YoRNz0uKIJUlTyiAlr1ej3hrhZ1idLy+gF67y
        XI6MJZ9YCeQnKOYqbio2feoLr
X-Received: by 2002:a17:902:ecd0:b0:196:8445:56be with SMTP id a16-20020a170902ecd000b00196844556bemr5788446plh.42.1675308302885;
        Wed, 01 Feb 2023 19:25:02 -0800 (PST)
X-Google-Smtp-Source: AK7set/pvefWS1/CpqW1NscmlurIGYYGDzwh8/dBgY5gfye1noE+4RvwU+vANRnhJEPiWLcmieADdw==
X-Received: by 2002:a17:902:ecd0:b0:196:8445:56be with SMTP id a16-20020a170902ecd000b00196844556bemr5788421plh.42.1675308302560;
        Wed, 01 Feb 2023 19:25:02 -0800 (PST)
Received: from [10.72.14.0] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709027c0500b00198b0fd363bsm2034171pll.45.2023.02.01.19.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 19:25:02 -0800 (PST)
Message-ID: <f9651a67-e3c2-9cee-5863-cb3f15a507be@redhat.com>
Date:   Thu, 2 Feb 2023 11:24:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Linux guest kernel threat model for Confidential Computing
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Christophe de Dinechin Dupont de Dinechin 
        <cdupontd@redhat.com>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <Y9JyW5bUqV7gWmU8@unreal>
 <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <702f22df28e628d41babcf670c909f1fa1bb3c0c.camel@linux.ibm.com>
 <DM8PR11MB5750F939C0B70939AD3CBC37E7D39@DM8PR11MB5750.namprd11.prod.outlook.com>
 <220b0be95a8c733f0a6eeddc08e37977ee21d518.camel@linux.ibm.com>
 <DM8PR11MB575074D3BCBD02F3DD677A57E7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
 <261bc99edc43990eecb1aac4fe8005cedc495c20.camel@linux.ibm.com>
 <m2h6w6k5on.fsf@redhat.com> <20230131123033-mutt-send-email-mst@kernel.org>
 <6BCC3285-ACA3-4E38-8811-1A91C9F03852@redhat.com>
 <20230201055412-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230201055412-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/1 19:01, Michael S. Tsirkin 写道:
> On Wed, Feb 01, 2023 at 11:52:27AM +0100, Christophe de Dinechin Dupont de Dinechin wrote:
>>
>>> On 31 Jan 2023, at 18:39, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Tue, Jan 31, 2023 at 04:14:29PM +0100, Christophe de Dinechin wrote:
>>>> Finally, security considerations that apply irrespective of whether the
>>>> platform is confidential or not are also outside of the scope of this
>>>> document. This includes topics ranging from timing attacks to social
>>>> engineering.
>>> Why are timing attacks by hypervisor on the guest out of scope?
>> Good point.
>>
>> I was thinking that mitigation against timing attacks is the same
>> irrespective of the source of the attack. However, because the HV
>> controls CPU time allocation, there are presumably attacks that
>> are made much easier through the HV. Those should be listed.
> Not just that, also because it can and does emulate some devices.
> For example, are disk encryption systems protected against timing of
> disk accesses?
> This is why some people keep saying "forget about emulated devices, require
> passthrough, include devices in the trust zone".


One problem is that the device could be yet another emulated one that is 
running in the SmartNIC/DPU itself.

Thanks


