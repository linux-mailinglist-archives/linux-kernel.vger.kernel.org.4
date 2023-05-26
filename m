Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD7712285
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbjEZIoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242761AbjEZIoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:44:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D1D128
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:44:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3078cc99232so391737f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685090646; x=1687682646;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d+EoENykicvVhtEx+udnXdT2B4JfjP100xbZZvVxTGI=;
        b=UenbCjy/I9HgH2jdm7xkNf6QaTPRnGD3oJYBWp5gW4oKpljuc7vfgywIdXGGlztlNg
         WBf0GoDaqIVfpEVdwdc5TtB6YVVb0Az0KZa2PFh52MKWCOO7ZOVqX12Fe0P6bEm9nYuD
         7rik9Qe5TOHIQfHDdGe0FR+WPexBQKohZ3LdAXszvji4181FMT+PMnsh75WOkYxHAc6B
         uJXTQ/PBWyvmWnsm4Ii+AX7brHBuF63Bus1NWZyvhiJejHNCZExGzqs9+im3YcQqnE19
         YFt7Yu3IlZpyaIOy/Ks3dLgIR8yXPRN40wjaR9XsNed5xJy67QJFvhrT3y9PYA48il12
         dxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685090646; x=1687682646;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+EoENykicvVhtEx+udnXdT2B4JfjP100xbZZvVxTGI=;
        b=Fvl6Pxxy7xReWEnKXSlHie3gkYGpMbtG4fxvYMr0K7K4zoul4+9GKjIB6eS4qY+roI
         sOJEwlF5iWyi0TbTLDGW+977tIpRyEfCKkfcvB2CSH6lmJ/jCZ9jq3TGy2NwH1u+KSQH
         XKXlhlXiHGoU/CXHfBDeTCi9/X/JMcKpgTmWHc/59z1rVU2ZXn1SXT3VYv0ZTe9Y0snF
         3B78/Uc1KfkaMUkWdJBiE/+23d04zAAIufDfnl/FyZ5Ui5jiwDUQ89yPjAqQxtbEm62r
         6zA3XBKZIeU7gQAW5bY/Vv5WD//cAozubQfQ+QiARQUO6cFHkuKRkgHoGLYOcwScBtHN
         Vfiw==
X-Gm-Message-State: AC+VfDzAttNhvG5r9CRZKC3HwPJkfMsZbt88AS1EICZne7rN+G5U5/gg
        uIFljPzxskqG+aSn6fSwR/cqeg==
X-Google-Smtp-Source: ACHHUZ7RVhrzhanSXX26T3aKZBacngzR1xiMWVIi1+n3GAfzb+yNlrKHcOySJ8/US+hibf/xDoZPYg==
X-Received: by 2002:a5d:6291:0:b0:309:e24:57b3 with SMTP id k17-20020a5d6291000000b003090e2457b3mr826087wru.4.1685090646345;
        Fri, 26 May 2023 01:44:06 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id x6-20020a5d6506000000b0030639a86f9dsm4312201wru.51.2023.05.26.01.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:44:06 -0700 (PDT)
Date:   Fri, 26 May 2023 10:44:05 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <xiaobo55x@gmail.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>, maz@kernel.org,
        oliver.upton@linux.dev, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 09/11] KVM: riscv: selftests: Make check_supported
 arch specific
Message-ID: <20230526-d8d768a23cd6bdc274bc165c@orel>
References: <cover.1684999824.git.haibo1.xu@intel.com>
 <26dea518fc5e8da51e61db279d175364bfecd009.1684999824.git.haibo1.xu@intel.com>
 <20230525-705ddcbcd43aa63e3fd356c8@orel>
 <CAJve8onF9MFuaVsThFnhjWr6ZomB0Lhr9WXGvMiJDt5vrjeKLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8onF9MFuaVsThFnhjWr6ZomB0Lhr9WXGvMiJDt5vrjeKLg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 03:50:32PM +0800, Haibo Xu wrote:
> On Fri, May 26, 2023 at 12:40 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Thu, May 25, 2023 at 03:38:33PM +0800, Haibo Xu wrote:
> > > check_supported() was used to verify whether a feature/extension was
> > > supported in a guest in the get-reg-list test. Currently this info
> > > can be retrieved through the KVM_CAP_ARM_* API in aarch64, but in
> > > riscv, this info was only exposed through the KVM_GET_ONE_REG on
> > > KVM_REG_RISCV_ISA_EXT pseudo registers.
> > >
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > ---
> > >  tools/testing/selftests/kvm/get-reg-list.c | 32 +++++++++++-----------
> > >  1 file changed, 16 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
> > > index f6ad7991a812..f1fc113e9719 100644
> > > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > > @@ -99,6 +99,20 @@ void __weak print_reg(const char *prefix, __u64 id)
> > >  }
> > >
> > >  #ifdef __aarch64__
> > > +static void check_supported(struct vcpu_reg_list *c)
> > > +{
> > > +     struct vcpu_reg_sublist *s;
> > > +
> > > +     for_each_sublist(c, s) {
> > > +             if (!s->capability)
> > > +                     continue;
> >
> > I was going to say that making this function aarch64 shouldn't be
> > necessary, since riscv leaves capability set to zero and this function
> > doesn't do anything, but then looking ahead I see riscv is abusing
> > capability by putting isa extensions in it. IMO, capability should
> > only be set to KVM_CAP_* values. Since riscv doesn't use it, then it
> > should be left zero.
> >
> > If we're going to abuse something, then I'd rather abuse the 'feature'
> > member, but since it's only an int (not an unsigned long), then let's
> > just add an 'unsigned long extension' member.
> >
> 
> Good idea!
> 
> For the new 'extension' member in riscv, I think its use case should be
> identical to the 'feature' member in aarch64(KVM_RISCV_ISA_EXT_F
> was similar to KVM_ARM_VCPU_SVE)? If so, I think we can just reuse
> the 'feature' member since the data type was not a big deal.

You're right. An int is fine for the isa extension index, which is all we
need to represent.

Thanks,
drew
