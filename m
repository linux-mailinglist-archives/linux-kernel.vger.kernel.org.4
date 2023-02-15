Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF26988BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBOXW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBOXW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:22:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3665142BE9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:22:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ky6so1016102ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tabx9NVVhDi2NL80cED89hxZVqfHcpcD6w5gvEiG26Q=;
        b=Q8cRbK9bsfMvz1Nn6UBM35NtrHJymdIg7nZkemYtGgv/3Q3yDTJhJG+X81qDdYabIf
         xxrtKoM9CiUsnARz3yOk+5K7ZQQZ+AQV90O8Y3pMrOhGvrKc3sTzpKJ1yje35uhNEj4B
         uqqN3W2f/CoTRayN0vR+ZkTzIuArxuwqNE2BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tabx9NVVhDi2NL80cED89hxZVqfHcpcD6w5gvEiG26Q=;
        b=LyY3Pgt9hJ9m+27xTeGdO7kibUvKV0uL0k4aSS59g8obw5C3v4dngrjCUigj8NzBph
         Sx0GojiWQB2CvPXObJJnTYMGB/dloLNCwzXlG4slvQnZ91l48YalDJ/l/AYRWLFQd+M6
         zW6frjREKYKrtavZwQshxaOEQgHSfuJpHH7dXKGc0IyfitPzrJanNsrpqZ2Lr1aFexru
         vKb25kK+HgMsJW8g1AcIVNfSBrvuAmFAYDeujPDTR9Y/WTtUou1g2skojWWdC57vbmYs
         aVPSWRdRP98Nr0b8FOByeK4PbjX5GIGSdR8nQt/lumkRl3jbXm4757drvFeNQj3zZ7eN
         pTcw==
X-Gm-Message-State: AO0yUKX/Hia5q5TB5uV6YMc/bg9IUYrw2hlF9PcQSkLV7rCNzNd6lXc6
        3n73SzbBLprNlBbbMsowYaZCpcmqzjDmCXB6tJM=
X-Google-Smtp-Source: AK7set8mhtvoZE5CQfZjnGl4uQNkDOtnnHwL2D1NnaTpZeU5s/pb8ZHM8R/QfQl1/qe6sG1H86ZFvA==
X-Received: by 2002:a17:907:76b5:b0:8a4:e0a2:e77f with SMTP id jw21-20020a17090776b500b008a4e0a2e77fmr4229095ejc.34.1676503374220;
        Wed, 15 Feb 2023 15:22:54 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709063b1000b008b1390ad11esm2072024ejf.216.2023.02.15.15.22.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 15:22:53 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id u21so519305edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:22:52 -0800 (PST)
X-Received: by 2002:a50:99cf:0:b0:4ab:4994:e648 with SMTP id
 n15-20020a5099cf000000b004ab4994e648mr2049346edb.5.1676503372641; Wed, 15 Feb
 2023 15:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20230209072220.6836-1-jgross@suse.com> <efeaec9b303e8a3ec7a7af826c61669d18fd22dc.camel@intel.com>
 <e983da4b-71d5-1c9d-5efa-be7935dab8fc@suse.com> <cb98f918fbc8b58e0a8d6823b4f92ad1d4265cfe.camel@intel.com>
 <51a67208-3374-bbd9-69be-650d515c519f@suse.com>
In-Reply-To: <51a67208-3374-bbd9-69be-650d515c519f@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Feb 2023 15:22:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg2zK6GRFLv+LkDevcjcYqhGi-GazcHmr0F1j_9BXQ6Pg@mail.gmail.com>
Message-ID: <CAHk-=wg2zK6GRFLv+LkDevcjcYqhGi-GazcHmr0F1j_9BXQ6Pg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
To:     Juergen Gross <jgross@suse.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Cui, Dexuan" <decui@microsoft.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 12:25 AM Juergen Gross <jgross@suse.com> wrote:
>
> The problem arises in case a large mapping is spanning multiple MTRRs,
> even if they define the same caching type (uniform is set to 0 in this
> case).

Oh, I think then you should fix uniform to be 1.

IOW, we should not think "multiple MTRRs" means "non-uniform". Only
"different actual memory types" should mean non-uniformity.

If I remember correctly, there were good reasons to have overlapping
MTRR's. In fact, you can generate a single MTRR that described a
memory ttype that wasn't even contiguous if you had odd memory setups.

Intel definitely defines how overlapping MTRR's work, and "same types
overlaps" is documented as a real thing.

            Linus
