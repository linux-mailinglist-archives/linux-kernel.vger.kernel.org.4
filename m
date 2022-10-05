Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAC45F5B13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiJEUgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJEUga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:36:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8583C8CB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:36:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id nb11so242192ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2Re7iXmxWCc16aVxPj7jXQfr86b17TQ2/MaN7IUN2k=;
        b=Bd3kUt9pSuaO3Scmoy+GEswieHGai7AlVdf0McStQWtG0D3v6Yl0kQvU3oZz6IKJf2
         DxAcbzw/Zri8q4buHEvgvzc2hcin4PD1Ua93SW9O9OoGPBTKqVLtApwxu0GQvhjM72Uh
         TlWN91UFe/vh/AeC6mnFXoO000TDHaJzsNrf/qWlGIuzXp9yo2w1pdH64rho745KZO6F
         G5qWqbT5sfSOVCSIPq34MhPSv0V/OVRw7sTVVg3k7O1+KobzwFbktozz1aF9P5yYuQoo
         BnvsB+HfXw2xXrqRt3aym43XAqQWHSZectFmJtUoPHMJeeX3XzqNLdRORi/0DFIMaCe8
         pEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2Re7iXmxWCc16aVxPj7jXQfr86b17TQ2/MaN7IUN2k=;
        b=bW9smDC/cH9bdkZqiHFX7bf50zHHUIHkl7+vDVy5wwagWU/JVUT/CN9akMCr0Q0vEv
         vy9nmVvVclLAHPJgBLiV6ws3NnyYj/uotU7pYWu4EToIAw0Gr5uk+xP90syoPamZfULh
         keOWuvO2ECTaelHG39MumKsB5L6JEWQejp1nD5bQAjOBc2An4vPXv6Ew7pnrAArf/UN3
         nsoOzltOp5o/cvwQVv5qDlz3+OAK16jP3WgLhUNMqITFOFSBp7oz/oQYhD2M/XIN8qjg
         jMAOBvnLcFvoLYNCX3YyRlKK813edy14ytUhsR5IgUmZx6/3cn9JsSDedB7TgdpTJFrs
         w9pQ==
X-Gm-Message-State: ACrzQf3fYYFFlVvqOHEUvle6SjJs+Xc4Uig2TUdU1xd8o1IxtHcDCvs9
        oIegcETjucpejHFtqW0zkWsPq3l8J95DXT991Pg4sw==
X-Google-Smtp-Source: AMsMyM4gOvihBgNAuFstuwa6PPhhWu6YCOZvfZTBC5eQxXbnEZQLmWMYXNYzk8inQK+JMg7+VFMoCXhcCxLzknb+88o=
X-Received: by 2002:a17:906:1e08:b0:73d:c724:4876 with SMTP id
 g8-20020a1709061e0800b0073dc7244876mr1147718ejj.62.1665002186127; Wed, 05 Oct
 2022 13:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com> <20220722171534.3576419-3-dlatypov@google.com>
In-Reply-To: <20220722171534.3576419-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Oct 2022 16:36:15 -0400
Message-ID: <CAFd5g450Jgxu=HYVpj8YmrtF9Hd3K9fuTHBp-Q5ZK+w=YVxO+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] kunit: make kunit_kfree() only work on pointers
 from kunit_malloc() and friends
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 1:15 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> kunit_kfree() exists to clean up allocations from kunit_kmalloc() and
> friends early instead of waiting for this to happen automatically at the
> end of the test.
>
> But it can be used on *anything* registered with the kunit resource API.
>
> E.g. the last 2 statements are equivalent:
>   struct kunit_resource *res = something();
>   kfree(res->data);
>   kunit_put_resource(res);
>
> The problem is that there could be multiple resources that point to the
> same `data`.
>
> E.g. you can have a named resource acting as a pseudo-global variable in
> a test. If you point it to data allocated with kunit_kmalloc(), then
> calling `kunit_kfree(ptr)` has the chance to delete either the named
> resource or to kfree `ptr`.
> Which one it does depends on the order the resources are registered as
> kunit_kfree() will delete resources in LIFO order.
>
> So this patch restricts kunit_kfree() to only working on resources
> created by kunit_kmalloc(). Calling it is therefore guaranteed to free
> the memory, not do anything else.
>
> Note: kunit_resource_instance_match() wasn't used outside of KUnit, so
> it should be safe to remove from the public interface. It's also
> generally dangerous, as shown above, and shouldn't be used.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
