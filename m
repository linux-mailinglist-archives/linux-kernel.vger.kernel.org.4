Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B927714846
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjE2LBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjE2LBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:01:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33906ED
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:00:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso627082366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685358044; x=1687950044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83jhJNkWMwv2xEBpts8kpySt/1KhQx2X32FHoz9hyjw=;
        b=OiywrWMOeb+v9DQlE73IRz4YdmiFzkEjsLqXxqF+F9y7IKE4qFJTapiPBXidk5yslL
         AwlISE/uUvhlbnnWkWaB9w4yfQe+J9tNL/c3DmH8Xwt2Oj0VIFswUdpQgvAqDiPRBULI
         5+bREM9vA9B9Ln0sZ8mvpvMKlxqNULZ2XoSWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685358044; x=1687950044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83jhJNkWMwv2xEBpts8kpySt/1KhQx2X32FHoz9hyjw=;
        b=T11t0BsxKQx1MggQjr2Owqxa8781ENhpLpaGTW1hVD1Lc0rPEoGFP/YxllrLx/g4gz
         7MOG9YX8Uz+SM8LEpmf5/kn+fKTJ+TrOjeoHC/pQMwafalACaHmiHMtwzJZGStm4O3lS
         MXdczRi0bCaw3Sbvf2H1kz5QRt09W/PU/XrKt76Pdq7WRlelZL8ngSJE1DDMHJGGUcOq
         KhxZ1/gdk54kQaIGk84WsA2lQfJ4cYt4PkJPvyrbjUd6mnwEiq4jYiP4f0zBfD1Cq537
         57CIsjNRFq1Lze54IlAZdwqZyUzUmzAGCzvXy0EDWZqNi8BJBJKucRAEb54unFLp/SI0
         /a/A==
X-Gm-Message-State: AC+VfDy10k1fom4edZCqQZ/m9PRS83Q1h6emt9mo0uUFG0QagiQh7vIm
        mOHw4MWpGdpNigz7T7pW4s3rcy/dyP8kcgEKAioQoWiw
X-Google-Smtp-Source: ACHHUZ5g+I4Ct3mPB/806hnY2fIJzegLIcgaSqTE1qs6m6O68OfxXw2KG6b2UBscw7xNHi6BmFRskA==
X-Received: by 2002:a17:906:eec8:b0:968:4ce9:677a with SMTP id wu8-20020a170906eec800b009684ce9677amr10672548ejb.38.1685358044399;
        Mon, 29 May 2023 04:00:44 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709064d9100b00969f25b96basm5731996eju.204.2023.05.29.04.00.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 04:00:44 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso627077266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:00:43 -0700 (PDT)
X-Received: by 2002:a17:907:987:b0:96a:6723:da47 with SMTP id
 bf7-20020a170907098700b0096a6723da47mr9992607ejc.43.1685358023375; Mon, 29
 May 2023 04:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com> <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org> <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
In-Reply-To: <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 May 2023 07:00:05 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
Message-ID: <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Johan Hovold <johan@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 4:58=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> I have not tried to figure out exactly why things break, but it does
> seem like this one should be reverted.

Yes, I have done so.

However, can I ask you to just verify that it was purely the exclusive
open part, and it wasn't that I messed up something else. IOW, can you
replace the

        return exclusive_deny_write_access(file);

in prepare_file_for_module_load() with just a "return 0", and remove the

                allow_write_access(f.file);

line in finit_module()?

That's obviously _instead_ of the revert that I already pushed out,
just to verify that "yup, it's that part, not something silly
elsewhere"

I do wonder what it is that is different in your setup, and maybe you
could also enable the

        pr_debug("finit_module: fd=3D%d, uargs=3D%p, flags=3D%i\n", fd, uar=
gs, flags);

in finit_module() while you are at it? Since you'd be editing that
file anyway for the test, just change the pr_debug() to a printk() and
then do

    dmesg | grep finit_module

to see what it all results in (on a working kernel, of course).

                    Linus
