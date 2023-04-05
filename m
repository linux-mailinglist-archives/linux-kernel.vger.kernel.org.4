Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09E36D8B47
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjDEX7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDEX72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:59:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2308559D6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:59:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-545e529206eso312161467b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680739166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gyCr9OUcPLoeGPEHX6a4SD6RRnehB93fDgoV/FBdOb0=;
        b=jSASHtikqaA+W7+SCU+z5kmfTP7TKJjZibXBeQPXnNJ+JZ/x8lZxPIGQzQHRQ+Q6iR
         8FSoSIywsARlIIBDUoXneqQ+VHub9WFiz+ggHKC/DD+0nwQHrURFKn9/YNL/uqTs+aHK
         34kv1vJ5sEfUpFI4kMljruRW4fUtmDtZ7VizjUpkqB4Shk8yb1Sv8otcWtZD5MBxIcaQ
         47Jp4me3B4MvHAIo56Mo0Jnn+wJR87GdGQEY7CpHLz5NslLPCHJWCjIxoJ0xaYjqBjMr
         THR6U6l5CA6EBPezdjoYzMUJq631c6osEwZCovKin+o78FpBayNY2gqFeeo3D/iMsT4l
         Mm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyCr9OUcPLoeGPEHX6a4SD6RRnehB93fDgoV/FBdOb0=;
        b=gdthOJAteWBlMHt8GAM1nyEYjAl5fIEGJKCjMiDj+6XrxK7LctGKN+FKPrXSn9ZjJt
         Jz+w635cOyiZ5iFPY+dEcos2IFWPk/QxMQ4/F56OOjdRjT9RYcjqZp5CYELVC7u8p1Gm
         96IqAC00klz0qp9PWcXmmtXhAnivBlmGLTiDiEgBZ9DH57rSUuBocO77aphyW42PQnbl
         nprpYsVzyCOrmkSAma8wp5fUdosiF3XbHkG+OHJw1fSYnA1UjvFv2y+k2u/amjv5j1k3
         nDFyvyWJTKOyC5ik8axVIlx8rkikuz+KMiY/hJR1Niip1lTQWD2lWStR7TCZZD0DUNVg
         LdSw==
X-Gm-Message-State: AAQBX9c3DgrCJdJEFJnDVwNYGFt4ylerWMdQM91Sm08dv0kGqDKNBI/z
        7IPywdShozMYjpgeA/yKagfUxidFdrw=
X-Google-Smtp-Source: AKy350bUPui1x5zNkOqG8Xc/ByIYKS1l7yISdqFbXRK2eFwGdGqyYGogu0fUP9ktJ+wOOyjTPO8JFL7Zi5Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:441e:0:b0:540:62be:42b with SMTP id
 r30-20020a81441e000000b0054062be042bmr4798963ywa.6.1680739166441; Wed, 05 Apr
 2023 16:59:26 -0700 (PDT)
Date:   Wed,  5 Apr 2023 16:59:13 -0700
In-Reply-To: <20230404010141.1913667-1-trix@redhat.com>
Mime-Version: 1.0
References: <20230404010141.1913667-1-trix@redhat.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <168073838093.697026.15762641048801886450.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: set varaiable mitigate_smt_rsb
 storage-class-specifier to static
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        Tom Rix <trix@redhat.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"varaiable" in the shortlog is mispelled, I just dropped it and wrapped the
variable name itself in quotes.

On Mon, 03 Apr 2023 21:01:41 -0400, Tom Rix wrote:
> smatch reports
> arch/x86/kvm/x86.c:199:20: warning: symbol
>   'mitigate_smt_rsb' was not declared. Should it be static?
> 
> This variable is only used in one file so it should be static.
> 
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: set "mitigate_smt_rsb" storage-class-specifier to static
      https://github.com/kvm-x86/linux/commit/944a8dad8b4e

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
