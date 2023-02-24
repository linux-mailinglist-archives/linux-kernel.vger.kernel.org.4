Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0146F6A1F52
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBXQGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBXQGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:06:39 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A362961ED4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:06:36 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cq23so56375076edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p1FN9nq7chgygC5NWZzWMsQda297W5OS4KEAh+SuMus=;
        b=ROuAwM4tAg+0iPPS4RRwf6U41AYovrmQQIr053RV82OWjRNJcwmgCd6EQZWBUDcuGl
         /YVUiED8jw7JQASfhrW9ek4MlJhqfPYCZ1uL7j8YbV641zREe/AnXkbLos/4aIYT+sxu
         AZKf48FLhcgz6ZmoERs6q2Q6vFuFae0IFc4mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1FN9nq7chgygC5NWZzWMsQda297W5OS4KEAh+SuMus=;
        b=eWmFgCrsi9YvhfUaHw3lCG0Imc8L0nukONrVeTcgRRgt6kJmsrEjdGyn4mgFrY+OdK
         /UCwamjKQbDzJgHeU9i1tD5lujNhzYTcSYYmXxRl82/Ge9zGCtGU2st8fhoTT8jpRzC2
         CrYWVRbfh/u5nYpaRI6PH+BDff10Q9IJX0JdivXLdsbHDDtiK1bmHBYYB1MmQwb02U3Y
         5+oMVa5vrSXtFPlsijMGQuMYMWbKH9U0C2+crdqQcvmxzEeIyee97WdV+c716cqhU8KY
         z6GNxboZqw0LsYZaV6N7ixINkbJPrjbsbh70w8GgSnepf2Xe/N6lCtLZAz0XYWd12wZ6
         GfSQ==
X-Gm-Message-State: AO0yUKUm5LSsyEsxe2QvduG/hUPVxn39SZnUDnjEG3+lUwmaVfq/PzgR
        Ru6UMPsE5YdCCzp+gKanPLkOHbhSfEaJbcAlCDjWqg==
X-Google-Smtp-Source: AK7set8SrKnDcMUlF1IHSSk74VIexXKs6TG635LLwb/P7n2AjrPlCeWG9VkHwOiLV4sALVuuHtlCrg==
X-Received: by 2002:a17:906:fb07:b0:8b1:7857:2331 with SMTP id lz7-20020a170906fb0700b008b178572331mr30756431ejb.65.1677254794869;
        Fri, 24 Feb 2023 08:06:34 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id p20-20020a1709060dd400b008be5b97ca49sm8369533eji.150.2023.02.24.08.06.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 08:06:33 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id ee7so41538649edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:06:33 -0800 (PST)
X-Received: by 2002:a50:9fae:0:b0:4ab:4d34:9762 with SMTP id
 c43-20020a509fae000000b004ab4d349762mr7669709edf.5.1677254793184; Fri, 24 Feb
 2023 08:06:33 -0800 (PST)
MIME-Version: 1.0
References: <2009825.1677229488@warthog.procyon.org.uk> <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
 <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <2134430.1677240738@warthog.procyon.org.uk> <2213409.1677249075@warthog.procyon.org.uk>
In-Reply-To: <2213409.1677249075@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 08:06:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=whFKL4VuFBWvenG8fAgfvbf36PDgouUSx47rZDWr9BkJw@mail.gmail.com>
Message-ID: <CAHk-=whFKL4VuFBWvenG8fAgfvbf36PDgouUSx47rZDWr9BkJw@mail.gmail.com>
Subject: Re: [RFC][PATCH] cifs: Fix cifs_writepages_region()
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <stfrench@microsoft.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000025890805f57450f3"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000025890805f57450f3
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 24, 2023 at 6:31 AM David Howells <dhowells@redhat.com> wrote:
>
> Here's the simplest fix for cifs_writepages_region() that gets it to work.

Hmm. The commit message for this is wrong.

> Fix the cifs_writepages_region() to just skip over members of the batch that
> have been cleaned up rather than retrying them.

It never retried them. The "skip_write" code did that same

                        start += folio_size(folio);
                        continue;

that your patch does, but it *also* had that

                        if (skips >= 5 || need_resched()) {

thing to just stop writing entirely.

> I'm not entirely sure why it fixes it, though.

Yes. Strange. Because it does the exact same thing as the "Oh, the
trylock worked, but it was still under writeback or fscache" did. I
just merged all the "skip write" cases.

But the code is clearly (a) not working and (b) the whole skip count
and need_resched() logic is a bit strange to begin with.

Can you humor me, and try if just removing that skip count thing
instead? IOW, this attached patch? Because that whole "let's stop
writing if we need to reschedule" sounds truly odd (we have a
cond_resched(), although it's per folio batch, not per-folio), and the
skip count logic doesn't make much sense to me either.

SteveF?

              Linus

--00000000000025890805f57450f3
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_leiq6lh00>
X-Attachment-Id: f_leiq6lh00

IGZzL2NpZnMvZmlsZS5jIHwgMTIgLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9maWxlLmMgYi9mcy9jaWZzL2ZpbGUuYwpp
bmRleCA1MzY1YTMyOTkwODguLjcwNjFkMjYzMzE1ZCAxMDA2NDQKLS0tIGEvZnMvY2lmcy9maWxl
LmMKKysrIGIvZnMvY2lmcy9maWxlLmMKQEAgLTI4NTgsNyArMjg1OCw2IEBAIHN0YXRpYyBpbnQg
Y2lmc193cml0ZXBhZ2VzX3JlZ2lvbihzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywKIAkJ
CQkgIGxvZmZfdCBzdGFydCwgbG9mZl90IGVuZCwgbG9mZl90ICpfbmV4dCkKIHsKIAlzdHJ1Y3Qg
Zm9saW9fYmF0Y2ggZmJhdGNoOwotCWludCBza2lwcyA9IDA7CiAKIAlmb2xpb19iYXRjaF9pbml0
KCZmYmF0Y2gpOwogCWRvIHsKQEAgLTI5MjcsMTcgKzI5MjYsNiBAQCBzdGF0aWMgaW50IGNpZnNf
d3JpdGVwYWdlc19yZWdpb24oc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJCQlyZXR1
cm4gcmV0OwogCiBza2lwX3dyaXRlOgotCQkJLyoKLQkJCSAqIFRvbyBtYW55IHNraXBwZWQgd3Jp
dGVzLCBvciBuZWVkIHRvIHJlc2NoZWR1bGU/Ci0JCQkgKiBUcmVhdCBpdCBhcyBhIHdyaXRlIGVy
cm9yIHdpdGhvdXQgYW4gZXJyb3IgY29kZS4KLQkJCSAqLwotCQkJaWYgKHNraXBzID49IDUgfHwg
bmVlZF9yZXNjaGVkKCkpIHsKLQkJCQlyZXQgPSAwOwotCQkJCWdvdG8gd3JpdGVfZXJyb3I7Ci0J
CQl9Ci0KLQkJCS8qIE90aGVyd2lzZSwganVzdCBza2lwIHRoYXQgZm9saW8gYW5kIGdvIG9uIHRv
IHRoZSBuZXh0ICovCi0JCQlza2lwcysrOwogCQkJc3RhcnQgKz0gZm9saW9fc2l6ZShmb2xpbyk7
CiAJCQljb250aW51ZTsKIAkJfQo=
--00000000000025890805f57450f3--
