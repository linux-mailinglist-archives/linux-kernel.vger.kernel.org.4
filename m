Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0545EFD8A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiI2TBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiI2TBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:01:19 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6196F1231ED
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:01:17 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-131c8ccae75so2915747fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CjLH+7U+sZfFHXWVsg+A2jTXjnVK6LjBkvT3fBCaSeA=;
        b=Iu5QDSSRxclcJVVKnZyR/7ber2Bs/dhKEQuq5OEWNriUvYhlbjDm9Jei3Djf+nsuKQ
         eWC3OFhn7DBL256DSdxAGxDvpvA4Q1l8xPbZBmSSioQgV7azxjX9/zxolqyKvyZVysP+
         YhTHlTaCmPpe/U4eREnWR+3gXyVYwC2PlKo/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CjLH+7U+sZfFHXWVsg+A2jTXjnVK6LjBkvT3fBCaSeA=;
        b=GkFgku1is5Ylhn7N11eS6T34+/vZslqnPiWclAvOxd/X+j5uPbDVQBe/7uDvJKon7+
         HS/zmOJd3svMS5WF3VJQn6gPANbGckaMU47S8z2RhYSbdrrAV9dn1cNhpBJjdZF9bnNv
         ZvSeqMzNhAD34Pd16XTIzMAj0GYQCyNXqWEnLO5UNTzU+ql0q7W0BLXjYXvHfjE3S5Zc
         e/V7WRxkiA660k4oUjHBv86GoXiM8KhmUMLFek0gbQHqnxJPZUzZY/PsBoOu7RIij3et
         X/I9JpzMPCzSpkZ8BnNQnyPbfX8FHuNxchHgKQZRAnOBZKtzU769tJce5E38QaWQcRnz
         gFMA==
X-Gm-Message-State: ACrzQf1Ehturg0HKAqJqhSvPnaprlqLRfgUpFoIuceIPsLMnVeTB2Q70
        jFfoSgj0cRx99+AO/9jbx4PzUxnNooA4FA==
X-Google-Smtp-Source: AMsMyM4xsObozm/2ger2TsEANSR10VrbE/gtO1hWF7Wyc2Hi7ArRGA3E62u4JvXHjaR/gz9WDTF2SQ==
X-Received: by 2002:a05:6870:e9a9:b0:12d:8e4b:5c02 with SMTP id r41-20020a056870e9a900b0012d8e4b5c02mr9303758oao.299.1664478076135;
        Thu, 29 Sep 2022 12:01:16 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id bx14-20020a0568081b0e00b00342fedaf7d9sm30791oib.43.2022.09.29.12.01.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 12:01:15 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id l5so2547049oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:01:15 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr2263698oif.126.1664478075017; Thu, 29
 Sep 2022 12:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <dacfc18d6667421d97127451eafe4f29@AcuMS.aculab.com>
 <CAHk-=wgS_XpzEL140ovgLwGv6yXvV7Pu9nKJbCuo5pnRfcEbvg@mail.gmail.com> <YzXo/DIwq65ypHNH@ZenIV>
In-Reply-To: <YzXo/DIwq65ypHNH@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2022 12:00:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizrMKtFxtK-5b-RmC2T562A8iHSYpnAygu__U-HcG_3A@mail.gmail.com>
Message-ID: <CAHk-=wizrMKtFxtK-5b-RmC2T562A8iHSYpnAygu__U-HcG_3A@mail.gmail.com>
Subject: Re: [PATCH 3/4] proc: Point /proc/net at /proc/thread-self/net
 instead of /proc/self/net
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
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

On Thu, Sep 29, 2022 at 11:50 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What do you mean?  Lookup on "net" in /proc returning what, exactly?

Returning the same directory as "thread-self/net", just not with a
symlink so that Apparmor doesn't get to mess things up..

> What would that dentry have for ->d_parent?

In a perfect world, I think it should act like a dynamic bind mount
(where the "dynamic" part is that thread-self part, and the parent
would be /proc.

That said, I think this is all a hack to deal with an Apparmor bug, so
I don't think we need perfect. Right now it's a symlink, so the parent
is the thread-self directory. I think that kind of magic jump would be
perfectly acceptable.

We have "magic jump" behavior in other /proc places, where the thing
*looks* like a symlink (ie readlink and friends just work), but the
lookup doesn't *actually* follow the symlink, it just looks things up
directly. IOW, all the /proc/<pid>/fd/<X> stuff.

So I think this would be just another case of that.

                Linus
