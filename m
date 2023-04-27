Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89C56F0AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbjD0RU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243741AbjD0RUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5CA4C03
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682616002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aPZaawwQwmja+K3dcGcTuaq8agrRF4dPj3IVyzF/XkQ=;
        b=hrnFYJl8rrIIf/fkaiSiUHas72VAoaSbbPr1Y+8m1qE2l5YGE5koRuS7+weFC4+yPPCLUI
        bwNeohM7qVRHvrFGK7Fb59yOdA2zOxtxvssO/+h3pnLhZTchALEtzIBktPrVFCMGa+bMsu
        rDaR2de0dKalckxl5SYYvTiI5Ok9nYg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-xZkJf_KzMzajX84VG0-D0Q-1; Thu, 27 Apr 2023 13:20:00 -0400
X-MC-Unique: xZkJf_KzMzajX84VG0-D0Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f1763fac8bso56309505e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682615999; x=1685207999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPZaawwQwmja+K3dcGcTuaq8agrRF4dPj3IVyzF/XkQ=;
        b=T9uh0yLZFWktDXM5ksyzGK/lECzXdcc9LzGygyXRLNV6Ez+OQfRcvTRZGcdKu3Yjn+
         oETDJdpMW9YEo1AS2k3ReAbofOv8EogfhwgfgVAmTkisb+N/i80+4BmPOeNdDLGpaeae
         Jg0tEdHkQDwzHquftNTuvv2tkKDbB5Zz+BZ/7YiGWwoDq9xOqlVQhFbAvZb75arT1zk6
         fh6gB/rsdjg/ZasRgFv0GRtW/7myEONKEsMgbMqxcNBNH2R5iXkjHMgzDJ4wxNGtx50Z
         7YVR4+Sl6VSk9VXBowIh58NUfPsBmm6a8OvQ15PUE5Dp75Avxp9AYtoLY1mk1WNUOZ+2
         Sl9w==
X-Gm-Message-State: AC+VfDww3Co2coS46+VxzrdiwVyVuluIQESL0gW4WwT0VNAh6aoFQ2tu
        v/YzEig55GiJMATbgbf5uElEegv6uekwNpaGfEAQwe5svyWxnaT2a55OXHpOr8AlaHUFWxeXOQm
        JncVAYsYq0sq25wPX7Cxcb9Xo
X-Received: by 2002:a1c:7211:0:b0:3f1:728a:1881 with SMTP id n17-20020a1c7211000000b003f1728a1881mr2052010wmc.31.1682615999325;
        Thu, 27 Apr 2023 10:19:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70FFgxaq7kngAV3kmqtfIdd11f8yMp/CFv4NyF+1cHylAzDbnw4IznX9hsPqVdLe7DOiNRfg==
X-Received: by 2002:a1c:7211:0:b0:3f1:728a:1881 with SMTP id n17-20020a1c7211000000b003f1728a1881mr2051980wmc.31.1682615998938;
        Thu, 27 Apr 2023 10:19:58 -0700 (PDT)
Received: from redhat.com ([2.52.19.183])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b003f17b96793dsm25084430wmk.37.2023.04.27.10.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:19:58 -0700 (PDT)
Date:   Thu, 27 Apr 2023 13:19:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Christopherson, , Sean" <seanjc@google.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
Message-ID: <20230427131542-mutt-send-email-mst@kernel.org>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com>
 <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <7502e1af0615c08167076ff452fc69ebf316c730.camel@linux.ibm.com>
 <ZElOfzn37kmesy7e@google.com>
 <DM8PR11MB57509EBCB1E2146C1768A6EEE76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <efda0be02fb0b5bf23aec11b5398d20908a821ba.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efda0be02fb0b5bf23aec11b5398d20908a821ba.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 09:18:08AM -0400, James Bottomley wrote:
> I think the problem is that the tenor of the document is that the CSP
> should be seen as the enemy of the tenant. Whereas all CSP's want to be
> seen as the partner of the tenant (admittedly so they can upsell
> services). In particular, even if you adopt (b) there are several
> reasons why you'd use confidential computing:
> 
>    1. Protection from other tenants who break containment in the cloud.
>       These tenants could exfiltrate data from Non-CoCo VMs, but likely
>       would be detected before they had time to launch an attack using
>       vulnerabilities in the current linux device drivers.
>    2. Legal data security.  There's a lot of value in a CSP being able
>       to make the legal statement that it does not have access to a
>       customer data because of CoCo.
>    3. Insider threats (bribe a CSP admin employee).  This one might get
>       as far as trying to launch an attack on a CoCo VM, but having
>       checks at the CSP to detect and defeat this would work instead of
>       every insider threat having to be defeated inside the VM.

And generally, all these are instances of adopting a zero trust
architecture, right? Many CSPs have no need to access VM memory
so they would rather not have the ability.

-- 
MST

