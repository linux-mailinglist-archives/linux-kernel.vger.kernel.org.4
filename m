Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC12661628
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 16:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjAHPWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 10:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjAHPVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 10:21:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6B4DF7E
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 07:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673191264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lvzedxyjzjfhn18TCWEa17dWo7Bik1OcNa64I2kf8bU=;
        b=GSmwSDnX4G7y9a3UQwpMNnzDx+mHrNXwfEyVf5FOgGPD+3+GMRO/0NN17pwAj+ZCz7xGsm
        sqzzhtJPAgpV6AupTsPmW4ksiNr6Y8SpFqAaFiXotn9q4egSSk7uCkjaGwz3+cxth86bmp
        EBKPl0PC5anLTSZWwHQW2m7WkIT3oJQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-378-pgpUjL5xOTyEd5lE229LCQ-1; Sun, 08 Jan 2023 10:21:00 -0500
X-MC-Unique: pgpUjL5xOTyEd5lE229LCQ-1
Received: by mail-ej1-f71.google.com with SMTP id hp2-20020a1709073e0200b0084d47e3fe82so66525ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 07:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lvzedxyjzjfhn18TCWEa17dWo7Bik1OcNa64I2kf8bU=;
        b=8O2jzv8m31sTgaauSEg6Yf1c17FckpsR+6aFOObdEgXL+M+K661+nmdNE2kNWYyCXT
         rTutHe0Odw3c+YUb16yY2iCmNNIE4AAjE5oWXw7d2LDW5+Pr7Uujk1Z09kg/X3zwzFmf
         ygpWWAuOsY8ak1f7kh8Mzad9CfvOaH3lSQExogASvWTSU2FadCMeOrsbkgsVAXF2lCDk
         mcx13BMoS63R8qH2zU4wVtULZCcBSePY2OpqG4+9kzc/1Z14kFsiTtnvEJD4xOoj4kNC
         W/WzogPd/T5BINl8N4V8ZsBPozSPVMCEwcEnvdiNB4aDtLCRFhmd/Tnpp7T0GbEOgjH7
         U7Mw==
X-Gm-Message-State: AFqh2kp3G+qzMy04SrA6vneM6BIkE3JOguVLtwjsdGM7HKBObKeFVevO
        mh1A73dSxN2zbhnbzyT7N4GrUySpQ9x+8UFqCi85WM5bJ9VmTySTQNHOwND6abeBEJj20IXdiLy
        tRRCGyQlm2OU7CWZVh112fPjo
X-Received: by 2002:a17:906:b150:b0:7c1:2931:2263 with SMTP id bt16-20020a170906b15000b007c129312263mr55960423ejb.71.1673191259113;
        Sun, 08 Jan 2023 07:20:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvYvEmE/ctylZg+rZQpibEIzhYwqZZzPWadIhdhuE1wX36yUyO7dl++P5gu1BrEk1W/O2kjoA==
X-Received: by 2002:a17:906:b150:b0:7c1:2931:2263 with SMTP id bt16-20020a170906b15000b007c129312263mr55960410ejb.71.1673191258924;
        Sun, 08 Jan 2023 07:20:58 -0800 (PST)
Received: from starship ([89.237.103.62])
        by smtp.gmail.com with ESMTPSA id x25-20020a170906b09900b0080345493023sm2553943ejy.167.2023.01.08.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 07:20:58 -0800 (PST)
Message-ID: <86ad9834f8de2b2babb2bb6839d45288432f62de.camel@redhat.com>
Subject: Re: [PATCH v5 27/33] KVM: SVM: Require logical ID to be power-of-2
 for AVIC entry
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>,
        Greg Edwards <gedwards@ddn.com>
Date:   Sun, 08 Jan 2023 17:20:56 +0200
In-Reply-To: <20230106011306.85230-28-seanjc@google.com>
References: <20230106011306.85230-1-seanjc@google.com>
         <20230106011306.85230-28-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-01-06 at 01:13 +0000, Sean Christopherson wrote:
> Do not modify AVIC's logical ID table if the logical ID portion of the
> LDR is not a power-of-2, i.e. if the LDR has multiple bits set.  Taking
> only the first bit means that KVM will fail to match MDAs that intersect
> with "higher" bits in the "ID"
> 
> The "ID" acts as a bitmap, but is referred to as an ID because there's an
> implicit, unenforced "requirement" that software only set one bit.  This
> edge case is arguably out-of-spec behavior, but KVM cleanly handles it
> in all other cases, e.g. the optimized logical map (and AVIC!) is also
> disabled in this scenario.
> 
> Refactor the code to consolidate the checks, and so that the code looks
> more like avic_kick_target_vcpus_fast().


Very minor nitpick about the subject, it feels like it just changes something
minor but it pretty much rewrites the avic_get_logical_id_entry.

When I bisected for the bug, this did confuse me a bit.

I don't have a good idea on how to call this patch so I won't object to the current
subject to stay as well.

Best regards,
	Maxim Levitsky


> 
> Fixes: 18f40c53e10f ("svm: Add VMEXIT handlers for AVIC")
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 5b33f91b701c..eb979695e7d8 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -513,26 +513,26 @@ unsigned long avic_vcpu_get_apicv_inhibit_reasons(struct kvm_vcpu *vcpu)
>  static u32 *avic_get_logical_id_entry(struct kvm_vcpu *vcpu, u32 ldr, bool flat)
>  {
>  	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
> -	int index;
>  	u32 *logical_apic_id_table;
> -	int dlid = GET_APIC_LOGICAL_ID(ldr);
> +	u32 cluster, index;
>  
> -	if (!dlid)
> -		return NULL;
> +	ldr = GET_APIC_LOGICAL_ID(ldr);
>  
> -	if (flat) { /* flat */
> -		index = ffs(dlid) - 1;
> -		if (index > 7)
> +	if (flat) {
> +		cluster = 0;
> +	} else {
> +		cluster = (ldr >> 4);
> +		if (cluster >= 0xf)
>  			return NULL;
> -	} else { /* cluster */
> -		int cluster = (dlid & 0xf0) >> 4;
> -		int apic = ffs(dlid & 0x0f) - 1;
> -
> -		if ((apic < 0) || (apic > 7) ||
> -		    (cluster >= 0xf))
> -			return NULL;
> -		index = (cluster << 2) + apic;
> +		ldr &= 0xf;
>  	}
> +	if (!ldr || !is_power_of_2(ldr))
> +		return NULL;
> +
> +	index = __ffs(ldr);
> +	if (WARN_ON_ONCE(index > 7))
> +		return NULL;
> +	index += (cluster << 2);
>  
>  	logical_apic_id_table = (u32 *) page_address(kvm_svm->avic_logical_id_table_page);
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

