Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785F15F0FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiI3QWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiI3QV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:21:56 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E5A1280DB
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:21:55 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-131dda37dddso5036889fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=0X+I+Y5o6UUwvWw7/p0q+ASco2yp37s0dxaq6uIyz/E=;
        b=VKoPaed7AhBlERynQ833bHq9eI6VqKPfLoBm/6bICdrHrzU21m6sHlAbExlGUYZR2N
         RTQJKLVU/RRDSAfr/h5T25wureIhmSdAA5MkuT75v7AJXHkgoHAoF/Qn3oAeWvtJoluO
         d4/YJumfBLNI9QUkLgSh0l+Pznn/xJwaELAj+n13Wz6aXpJSI2xVlkN85J0FkOemVwgW
         0ablzK59b+8x9XKzA+lQmPKvZYFqzaa24Q6KIXnB47v1Cj4ZQz4zsoiNFquE3vUF6hgw
         ObUP+PMlK9zK5aKVzp5zxXBX+fMMVeavsfq//BeRt2vremyu7KekDQppqZna+UIbVhBq
         ELsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=0X+I+Y5o6UUwvWw7/p0q+ASco2yp37s0dxaq6uIyz/E=;
        b=MN1HEE2Un2clBQyUlX5UnolMYfdzENoPTCFsEiuyJQyyGYc2VXVXmJANVLfmKdWrIW
         Ex2qETZpvha7znY8/gVOWwgQB6v+tfZcbId/44FiIng6FL1m8g31SeNCSkAa0Zz9W5bb
         A0uRcKn3BvTzJoDAVKk8d/JuzLSIiRYFB5IgGmGIjdCGeSwYVpKqMVxTIRL2Bhk/OmYK
         mlfNFjGTIPUoXoi7/RSflnzdTNfX2Kwwxan0b1fwWDc4Nim30auxai1DaguxPUGdg/BX
         dxUWagqD/lx5EsQ6wzjzjIriAgObAyX7IfIjs1AfK3A+5V/AU2euUWdW5Rm3ulCX4810
         zzHQ==
X-Gm-Message-State: ACrzQf2I0Lp2YXg0gAj1poF/ks/KLt6/Vvd5ZV/DzlLycFi2pij6gRiv
        JHf7AuGJi6N6qCHkHmbib1eJeQ==
X-Google-Smtp-Source: AMsMyM6nAVfkUsD3WRtMibcWeXLohDOrWEiEMtGwwRrsywi/KrsvsLg2qOU3qZNO06KdRZkQYdfoQA==
X-Received: by 2002:a05:6870:6390:b0:132:4b5:2e6f with SMTP id t16-20020a056870639000b0013204b52e6fmr1403555oap.110.1664554914584;
        Fri, 30 Sep 2022 09:21:54 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bd18-20020a056870d79200b0011f400edb17sm839681oab.4.2022.09.30.09.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:21:54 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:21:44 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Laight <David.Laight@aculab.com>
cc:     Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
In-Reply-To: <c1c8920a56014a179dbb82d483f2ad28@AcuMS.aculab.com>
Message-ID: <06329f-e498-ccc-6223-32f87716436d@google.com>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com> <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com> <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz> <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com> <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com> <c432330b-33f0-82d0-65f1-a548ce0658b1@suse.cz> <16fe443a-dabe-aa46-6bc7-dad03f29e0dc@google.com> <c1c8920a56014a179dbb82d483f2ad28@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 30 Sep 2022, David Laight wrote:
> > > > Regarding "conflicting" alignment requests: yes, I agree with you,
> > > > it would have to be a toolchain bug if when asked to align 2 and to
> > > > align 4, it chose not to align 4.
> 
> See https://godbolt.org/z/3nGsTaf5e
> the align() directive takes precedence.
> 
> Here you only want to ensure the alignment is at least 4.

Sorry, I don't understand the point you are making,
nor how to deduce it from the link which you give:
I'll leave it to those who understand better.

Hugh
