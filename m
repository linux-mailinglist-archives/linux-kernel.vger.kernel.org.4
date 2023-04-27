Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777306F081B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244163AbjD0PTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbjD0PTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:19:02 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1604495
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:19:00 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1a681ad22c8so53477065ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682608740; x=1685200740;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96tlb4cNoJcCgE10H273pQD9ijy1ih2oOSASLKRE9RA=;
        b=B9P9p3oRb2CBdbm9CWbdyCK/nucae2EGpAlsCblo9mDN/lRgWAN1Ku83ChZU2ku51u
         cGwtpxaxyImwGmJEELqwjCR6CGLc9sOte9monJrlajGAoE1pJ6SeoiZSvRtIoJ+OCQSX
         dfUwJWtlglsocmLoe845ime1ijnnxnvtZKim/+b4RXAFbO9BFmwr7dI1QbQtHFCndLwJ
         z8AURsfaSLu2ANG9zFM0ST7XfiJDzeTma2VWGadUlaZOleBVWHNHQ5yMYOQF1lEQU41t
         h8qG0FzNgrhAlLIfeZhVWv9bqFG1rL5s1nnQYpYTJ8mz0+YDtrn7H4NbsY4ROx8OVLAE
         Ezjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682608740; x=1685200740;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=96tlb4cNoJcCgE10H273pQD9ijy1ih2oOSASLKRE9RA=;
        b=IZVlVC0H27HHX6ZfP2YMUbwxof6qfKVxMb+ULqvmDdQXjunxABMho+wD0SaJ14jOhd
         +moKq0cWfeJaNHr/70w9gmdEiR6DeWxbynqfi4cWTieY3zR2cov7LJibOTiLLBy4kGFs
         F6IX21SCV2K5Ks+cYrGqvzJay9tGSYndODY9KPduQR/rKm3sk/hwbsZxVR4UfcYwbFY2
         2+Su7V3Ju6lNoy3kmihRIdHqwzJaGqLIzpJxD14diRs5ZHlrKAnF3zaf+A+kCRWz8A58
         4i9XsRueb+K+n+oyrvn3OxlWs37DMO0w/lFZgqVPFtWhXOL6DS9xLKZs/RJyQOb3xgFG
         YjGw==
X-Gm-Message-State: AC+VfDw20hE35KnZdb/VYOcjBhoaDwVsXX3QvSo0NxTm6MNBNcUftknu
        IZLLL6aCV7h9Ky+4Ybi4bvmoYkb6nGQ=
X-Google-Smtp-Source: ACHHUZ50qd4blUbaXDb7lEisXCYr+IljkCjGN3LmpsZoacfv64lAa7NJlhTCBBJH6KQKoqiX33IZCkEbDC4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:b497:b0:1a6:6c4e:4aa5 with SMTP id
 y23-20020a170902b49700b001a66c4e4aa5mr588890plr.11.1682608739881; Thu, 27 Apr
 2023 08:18:59 -0700 (PDT)
Date:   Thu, 27 Apr 2023 08:18:58 -0700
In-Reply-To: <c99d6a6b-cb8b-c62d-7305-6b739a8c0671@amd.com>
Mime-Version: 1.0
References: <ZEfrjtgGgm1lpadq@google.com> <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9fa5ce43-584d-878d-227a-fb458254c00a@amd.com> <ZElIjw7Ca6N2mYHe@google.com>
 <9021d861-cde6-a51a-7d8c-b3f67eaa01d8@amd.com> <ZEmBULXp24oMxaUH@google.com>
 <04383d21-b71e-93dd-5f4c-b39f5bc21937@amd.com> <ZEmYR0fWl05lGW0d@google.com>
 <DM8PR11MB57502652613A19C1A65D10BDE76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <c99d6a6b-cb8b-c62d-7305-6b739a8c0671@amd.com>
Message-ID: <ZEqSRTirPCxjy6M4@google.com>
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat model
From:   Sean Christopherson <seanjc@google.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
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
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023, Carlos Bilbao wrote:
> On 4/27/23 7:29 AM, Reshetova, Elena wrote:
> > I agree with Dave that I think the goal of this document is not to come=
 up with a
> > fancy name (I am fine with call it anything), but to introduce kernel d=
evelopers to the=20
> > new Linux threat model angle for this-particular-use-case-of-confidenti=
al-computing.
> > So that when we submit the hardening mechanisms in the future people ar=
e=20
> > already familiar with why we need to do this and we don=E2=80=99t have =
to repeat this story=20
> > again and again.=20
>=20
> Yes! To reiterate, there's two things we definitely wish to do:
>=20
> 1. Narrow down the problem: This new document can be specific to CoCo in
>    virtual environments. v2 should be clear about that.

Then rename the document as I already suggested.  If you want to claim
confidential-computing.rst, then IMO such a doc needs to be written somethi=
ng
like the surprisingly good Wikipedia article[*].  Until one of those two th=
ings
happens, my NAK stands.

[*] https://en.wikipedia.org/wiki/Confidential_computing
