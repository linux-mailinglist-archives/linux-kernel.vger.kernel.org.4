Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E4865DC3C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbjADSf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjADSfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:35:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24368DF02
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672857273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GF8fqC6E7ylqKYopzfXyzsmLa7YHomXayutfQCeRVrM=;
        b=MIb18X+5yaRZRlCujRihmxNsit90fgQhTKP9If1dRH5Banx5ZZvE57dipDW/JPX+qygkch
        TEeNvVDOXsbkceSf5HtTgwRoRwiF8K3a1+QH7H8z3MEc9W8qM0ErfeJ4QX4kuj+J1A5fQg
        aR1S7h4E9l2UIop1dSX8AQciT2YnwRg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-620-z4nGKQkFPNqLuT_NuaImxg-1; Wed, 04 Jan 2023 13:34:32 -0500
X-MC-Unique: z4nGKQkFPNqLuT_NuaImxg-1
Received: by mail-wr1-f71.google.com with SMTP id s3-20020adf9783000000b002ab389f64c1so334670wrb.22
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 10:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GF8fqC6E7ylqKYopzfXyzsmLa7YHomXayutfQCeRVrM=;
        b=yvOTfXfH6O5RUrgEiESc/6GDhjGJ0t9lVZiSG8f641IKaK74Qkbsza6ZwuXVRirXMP
         u19gVSDWXt+349uYS3F/Qi54wq8nuSTq8B5IB7OOiqSt1RUL6rDElYNOkuplwu16yH4J
         KhkmT2QIXMKG+WNsN4kTk3GfkrR5L6Zen8+KzF7bGPgE1UakepMOsn2q5ca6DV7DWqqz
         HteGpjRqa8P8xDaMX5T4D01jICotYr01mCM00GqUQGzIMNCHLZUSVIRC12/PCVh6QSNf
         HCVfEeJg4F+JkGPZ4UxER185MVo8y9kr0DphrOrFoqwaZQht/jDLORulzh/yzmZEjd8C
         GTMQ==
X-Gm-Message-State: AFqh2kqY9g70fDHOP7PRW5QSvqZOsrWLkY+tldhT2+tMWTy4C4mk318R
        hqqwLOn1DncAsjbuyODrUXkmcvukCeV+pGi/tcnsKWlf0Wpr5NrXuIKzRBSesGB+tU4vdSH9Kji
        LfpML6L9MBLtQl0j3l2w2EDCg
X-Received: by 2002:a5d:4008:0:b0:242:7214:55e4 with SMTP id n8-20020a5d4008000000b00242721455e4mr29671098wrp.46.1672857270943;
        Wed, 04 Jan 2023 10:34:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsjA4ziS/bPJ0fKWYqVBReXXkQrg7PLMxn8KXo9BsHg3ddjQVKYe21WvCzcB+Xu66TXMVmYJQ==
X-Received: by 2002:a5d:4008:0:b0:242:7214:55e4 with SMTP id n8-20020a5d4008000000b00242721455e4mr29671090wrp.46.1672857270738;
        Wed, 04 Jan 2023 10:34:30 -0800 (PST)
Received: from starship ([89.237.103.62])
        by smtp.gmail.com with ESMTPSA id ba13-20020a0560001c0d00b002a91572638csm1391669wrb.75.2023.01.04.10.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 10:34:30 -0800 (PST)
Message-ID: <ac7beb326b44a45d5561803e62b8b94cd758a45d.camel@redhat.com>
Subject: Re: [PATCH v4 28/32] KVM: SVM: Require logical ID to be power-of-2
 for AVIC entry
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Date:   Wed, 04 Jan 2023 20:34:28 +0200
In-Reply-To: <Y7W/NinWOnJMtUk8@google.com>
References: <20221001005915.2041642-1-seanjc@google.com>
         <20221001005915.2041642-29-seanjc@google.com>
         <f1f1a33134c739f09f5820b5a4973535f121c0da.camel@redhat.com>
         <b002fd18c2abdfe5f4395be38858f461b3c76ac3.camel@redhat.com>
         <Y7W/NinWOnJMtUk8@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-01-04 at 18:02 +0000, Sean Christopherson wrote:
> On Thu, Dec 29, 2022, mlevitsk@redhat.com wrote:
> > On Fri, 2022-12-09 at 00:00 +0200, Maxim Levitsky wrote:
> > > On Sat, 2022-10-01 at 00:59 +0000, Sean Christopherson wrote:
> > > > +	} else {
> > > > +		cluster = (ldr >> 4) << 2;
> > > > +		if (cluster >= 0xf)
> > > >  			return NULL;
> > > > -	} else { /* cluster */
> > > > -		int cluster = (dlid & 0xf0) >> 4;
> > > > -		int apic = ffs(dlid & 0x0f) - 1;
> > > > -
> > > > -		if ((apic < 0) || (apic > 7) ||
> > > > -		    (cluster >= 0xf))
> > > > -			return NULL;
> > > > -		index = (cluster << 2) + apic;
> > > > +		ldr &= 0xf;
> > > >  	}
> > > > +	if (!ldr || !is_power_of_2(ldr))
> > > > +		return NULL;
> > > > +
> > > > +	index = __ffs(ldr);
> > > > +	if (WARN_ON_ONCE(index > 7))
> > > > +		return NULL;
> > > > +	index += (cluster << 2);
> > > >  
> > > >  	logical_apic_id_table = (u32 *) page_address(kvm_svm->avic_logical_id_table_page);
> > > >  
> > > 
> > > Looks good.
> > 
> > I hate to say it but this patch has a bug:
> > 
> > We have both 'cluster = (ldr >> 4) << 2' and then 'index += (cluster << 2)'
> > 
> > One of the shifts has to go.
> 
> The first shift is wrong.  The "cluster >= 0xf" check needs to be done on the actual
> cluster.  The "<< 2", a.k.a. "* 4", is specific to indexing the AVIC table.
> 
> Thanks!
> 

Yep, agree.

(I mean technically you can remove the second shift and do the check before doing the first shift, that
is why I told you that one of the shifts has to go)

Best regards,
	Maxim Levitsky

