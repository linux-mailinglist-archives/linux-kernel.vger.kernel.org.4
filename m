Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4815E69C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiIVRkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIVRkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:40:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBB157260
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:40:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d24so9462966pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=b4sJcP3BMvfK2lj3kZNN/gN51EYUtxkqzF+/QB85KVw=;
        b=LmxVbYRy9Vz8pds5VkW/DMBdVcJKsdkgj+IujFbTRIK8ILw2DDiZzW3F/fSpD38HlT
         CvIf2gijwIYT3TNdiu8gsy0jTl1sDUS18QfpBYKeHWF8z3SekjcFxSy8oU3cCQKlalrV
         flQMLv1pf9p9u8Z/ObT4hzv/GoOPtYPo4WrxWvcUmJDdfXXZpa7bzMDDLrqaHqXbl3z5
         pfy7KdhK1+fGRSKdVSXc6RNgTZyr4iqgw/f170jjlLQlnq2O/r9AT3jwiivWab84aFzD
         JJmd2H8MX9fRchtnKnDBzaHa9g6BQg5OQvssa4KKgOtJbGTXc0TO82edrsk2QubAi5nJ
         B7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=b4sJcP3BMvfK2lj3kZNN/gN51EYUtxkqzF+/QB85KVw=;
        b=YcWzi4osx+cBbuEGWGV6c/0TXXAc2/5D8rZJcon4nn/USvg1xrKKVa6aHe9p7tF8cm
         CyFAJp6DCmnj9ZVlgu3AxOT//K703uiG/H7c87/VrR+7dSC6f2F3xARDDO9NsYzRYl/7
         4I6PB0mTr/uueaYAHCfU0vmy1kBkCUW4DtyFtNzgv5YydvuZq4thzP3aby/aAtFXtsuR
         z/pH/BWePr/UCl8ARrolG8k4SMwB6ak36YrooeXaVNgrYZbJUErynIfCQjxf018Nd2tE
         /DO8if48vt5KUSFWx2A7s2HXiU43M7DjKQosGfKd3eDrZW8CTKpgO8yj70z8Aobgf77v
         1Qvw==
X-Gm-Message-State: ACrzQf2zNuxmj92vFRA+73SIaNe6zLInlkbHgO2mp/FaQVP87/rVcwPQ
        ToPcjCFWRW3AD+cBnRMoVkZW6g==
X-Google-Smtp-Source: AMsMyM464aLMS0sqrk0u9Upnudsae+q8fCdLhT44F0KsUa29837krHy2WbCruxPZYm9LW4bvL5rb8Q==
X-Received: by 2002:a17:902:ec83:b0:178:39e5:abee with SMTP id x3-20020a170902ec8300b0017839e5abeemr4301865plg.84.1663868406158;
        Thu, 22 Sep 2022 10:40:06 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ik27-20020a170902ab1b00b001732a019dddsm4370610plb.174.2022.09.22.10.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 10:40:05 -0700 (PDT)
Date:   Thu, 22 Sep 2022 17:40:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Jones <andrew.jones@linux.dev>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH 1/5] KVM: selftests: Implement memcmp(), memcpy(), and
 memset() for guest use
Message-ID: <Yyyd8UN+ZO1Yf/Co@google.com>
References: <20220908233134.3523339-1-seanjc@google.com>
 <20220908233134.3523339-2-seanjc@google.com>
 <Yyybg3DxgLt4NVn+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyybg3DxgLt4NVn+@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022, David Matlack wrote:
> > +LIBKVM_STRING += lib/kvm_string.c
> 
> Can this file be named lib/string.c instead? This file has nothing to do
> with KVM per-se.

Yes and no.  I deliberately chose kvm_string to avoid confusion with
tools/lib/string.c and tools/include/nolibc/string.h.  The implementations
themselves aren't KVM specific, but the reason the file _exists_ is 100% unique
to KVM as there is no other environment where tools and/or selftests link to
glibc but need to override the string ops.

I'm not completely opposed to calling it string.c, but my preference is to keep
it kvm_string.c so that it's slightly more obvious that KVM selftests are a
special snowflake.

> > diff --git a/tools/testing/selftests/kvm/lib/kvm_string.c b/tools/testing/selftests/kvm/lib/kvm_string.c
> > new file mode 100644
> > index 000000000000..a60d56d4e5b8
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/lib/kvm_string.c
> > @@ -0,0 +1,33 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include "kvm_util.h"
> 
> Is this include necesary?

Nope, I added the include because I also added declarations in kvm_util_base.h,
but that's unnecessary because stddef.h also provides the declarations, and those
_must_ match the prototypes of the definitions.  So yeah, this is better written as:

// SPDX-License-Identifier: GPL-2.0-only
#include <stddef.h>

/*
 * Override the "basic" built-in string helpers so that they can be used in
 * guest code.  KVM selftests don't support dynamic loading in guest code and
 * will jump into the weeds if the compiler decides to insert an out-of-line
 * call via the PLT.
 */
int memcmp(const void *cs, const void *ct, size_t count)
{
	const unsigned char *su1, *su2;
	int res = 0;

	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--) {
		if ((res = *su1 - *su2) != 0)
			break;
	}
	return res;
}

void *memcpy(void *dest, const void *src, size_t count)
{
	char *tmp = dest;
	const char *s = src;

	while (count--)
		*tmp++ = *s++;
	return dest;
}

void *memset(void *s, int c, size_t count)
{
	char *xs = s;

	while (count--)
		*xs++ = c;
	return s;
}
