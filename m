Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC2B637427
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiKXIh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKXIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:37:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABB8EC084
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669278988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u4GmOx2q5gJKD6SYU/1vAHoiNYQRo9PSyRAuDnoBM64=;
        b=BzPLwuGon6bPexchG+58y7GY4+/hitHHWvORjJtLGbEe1URrz3P+VqMUlxPrPrEirW4VCq
        nzBWO3aAiGPjVzh7A+7IjKXXAjGUp5O+GNtr1zwNC/938fXtkwNXWDUkFitDgqVXODMiuP
        7QHYlbF0cPHD4TZDYwochpmRkbwkPD8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-367-1f4IjRiaONGImp1dR8pGFA-1; Thu, 24 Nov 2022 03:36:27 -0500
X-MC-Unique: 1f4IjRiaONGImp1dR8pGFA-1
Received: by mail-ej1-f72.google.com with SMTP id oz34-20020a1709077da200b007adc8d68e90so780340ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4GmOx2q5gJKD6SYU/1vAHoiNYQRo9PSyRAuDnoBM64=;
        b=saUzi0us86wMfP7n+ovCXEpVU5NxCKQRf0FY8WhYK9fh5WsyI7IEP8bgNT+BA3RzLI
         h1P4S1RQ7QftHmZRkR1gVhFEVLj/yG+Pe1wXSiI3M8Zk1VMjk6yvvQnrUt1Y/7cIYPMu
         V4AZKN44MbScL+4NJtJsawht+4VSwE9pbc2aBCRRsLGbwEDJruFLjKC78E15lwm/3jZD
         ATw/L+HW0Jl6xo/sHqakT3Jo+WyEQAgVy/rEnIkJ6DWkUUvu7C+3n1balxB8FTB1xoag
         ZPt9RTDZiJcK/ypMUsdi5uUKR4AesDwLKDcv7YBD8QsKywZ4twG/WB7LX4GTwBdmyiuQ
         h+Ag==
X-Gm-Message-State: ANoB5pmZyQc9xeFOS5KVSUiWI/+HHP2OW7GZsMYDxBfLZeiPt/YQejCq
        jeEMCkPkCYc1AK8JO/QMzvt8j41hL/xz6puCL/Elqdl1OMXaoJH5IzQhiAkS5XpsfIqy0mxOLMa
        L3vVJTACcBDEgPkqjEUDdk4R2
X-Received: by 2002:a17:906:f281:b0:7ae:3b9e:1d8a with SMTP id gu1-20020a170906f28100b007ae3b9e1d8amr25550224ejb.581.1669278986165;
        Thu, 24 Nov 2022 00:36:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7eHOEJUopgc22MypWWRx0CICuyjIBgS4yczrp7s+2iDwN26cU+AeKzwAHAkrk0kb4IXGlKMQ==
X-Received: by 2002:a17:906:f281:b0:7ae:3b9e:1d8a with SMTP id gu1-20020a170906f28100b007ae3b9e1d8amr25550213ejb.581.1669278985941;
        Thu, 24 Nov 2022 00:36:25 -0800 (PST)
Received: from ovpn-192-146.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z21-20020aa7cf95000000b004614fd33789sm254331edx.18.2022.11.24.00.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 00:36:25 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Subject: Re: [PATCH v2 2/6] KVM: x86: hyper-v: Add extended hypercall
 support in Hyper-v
In-Reply-To: <CAHVum0eW4WMHe1vNsWn-2xbMxgckFwu_pOQR7hs0NbFj3sM8Tg@mail.gmail.com>
References: <20221121234026.3037083-1-vipinsh@google.com>
 <20221121234026.3037083-3-vipinsh@google.com>
 <87bkozosvh.fsf@ovpn-194-185.brq.redhat.com>
 <CAHVum0eW4WMHe1vNsWn-2xbMxgckFwu_pOQR7hs0NbFj3sM8Tg@mail.gmail.com>
Date:   Thu, 24 Nov 2022 09:36:24 +0100
Message-ID: <87wn7koik7.fsf@ovpn-192-146.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vipin Sharma <vipinsh@google.com> writes:

> On Tue, Nov 22, 2022 at 8:29 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Vipin Sharma <vipinsh@google.com> writes:
>>
>> > +/*
>> > + * The TLFS carves out 64 possible extended hypercalls, numbered sequentially
>> > + * after the base capabilities extended hypercall.
>> > + */
>> > +#define HV_EXT_CALL_MAX (HV_EXT_CALL_QUERY_CAPABILITIES + 64)
>> > +
>>
>> First, I thought there's an off-by-one here (and should be '63') but
>> then I checked with TLFS and figured out that the limit comes from
>> HvExtCallQueryCapabilities's response which doesn't include itself
>> (0x8001) in the mask, this means it can encode
>>
>> 0x8002 == bit0
>> 0x8003 == bit1
>> ..
>> 0x8041 == bit63
>>
>> so indeed, the last one supported is 0x8041 == 0x8001 + 64
>>
>> maybe it's worth extending the commont on where '64' comes from.
>>
>
> Yeah, I will expand comments.
>
>> >  static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
>> >                               bool vcpu_kick);
>> >
>> > @@ -2411,6 +2417,9 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
>> >       case HVCALL_SEND_IPI:
>> >               return hv_vcpu->cpuid_cache.enlightenments_eax &
>> >                       HV_X64_CLUSTER_IPI_RECOMMENDED;
>> > +     case HV_EXT_CALL_QUERY_CAPABILITIES ... HV_EXT_CALL_MAX:
>> > +             return hv_vcpu->cpuid_cache.features_ebx &
>> > +                             HV_ENABLE_EXTENDED_HYPERCALLS;
>> >       default:
>> >               break;
>> >       }
>> > @@ -2564,6 +2573,12 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>> >               }
>> >               goto hypercall_userspace_exit;
>> >       }
>> > +     case HV_EXT_CALL_QUERY_CAPABILITIES ... HV_EXT_CALL_MAX:
>> > +             if (unlikely(hc.fast)) {
>> > +                     ret = HV_STATUS_INVALID_PARAMETER;
>>
>> I wasn't able to find any statement in TLFS stating whether extended
>> hypercalls can be 'fast', I can imagine e.g. MemoryHeatHintAsync using
>> it. Unfortunatelly, our userspace exit will have to be modified to
>> handle such stuff. This can stay for the time being I guess..
>>
>
> I agree TLFS doesn't state anything about "fast" extended hypercall
> but nothing stops in future for some call to be "fast". I think this
> condition should also be handled by userspace as it is handling
> everything else.
>
> I will remove it in the next version of the patch. I don't see any
> value in verification here.

The problem is that we don't currently pass 'fast' flag to userspace,
let alone XMM registers. This means that it won't be able to handle fast
hypercalls anyway, I guess it's better to keep your check but add a
comment saying that it's an implementation shortcoming and not a TLFS
requirement.


>
>> > +                     break;
>> > +             }
>> > +             goto hypercall_userspace_exit;
>> >       default:
>> >               ret = HV_STATUS_INVALID_HYPERCALL_CODE;
>> >               break;
>> > @@ -2722,6 +2737,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>> >
>> >                       ent->ebx |= HV_POST_MESSAGES;
>> >                       ent->ebx |= HV_SIGNAL_EVENTS;
>> > +                     ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
>> >
>> >                       ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
>> >                       ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
>>
>> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>
>> --
>> Vitaly
>>
>

-- 
Vitaly

