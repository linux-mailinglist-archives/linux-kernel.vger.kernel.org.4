Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1294F5EE60A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiI1TxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbiI1TxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:53:08 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397447F0B3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:53:06 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i12so3871560qvs.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=XxBHVAN3/H6/8AwoH9JLtdYyyS4rrJJTr4ILYLxKwqw=;
        b=h5SBAA3xFe3qSgnADPV+zSL46+Ioa4kVE7DVApCf0zIzWBQ9d/Pu1byQqxVHmFGd+e
         Kw7MwRf2RIo2eXC8dIAgdeAbBRu5jbyThHW5tHdOovlmg1kF/lBdtdH/Jl20g50nk0Rm
         oDdz0LXhpl9hgDqoqYqWyoch4e2WP4V6XEo04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XxBHVAN3/H6/8AwoH9JLtdYyyS4rrJJTr4ILYLxKwqw=;
        b=YIjNvmCMa9BWhQlft3pYyM7eXHqaKh88WcceVX7PJop4E7eilMMlVPBwG6Ou1ePhye
         ar1f7od9bBItOe26iu+qBH42JEsp8hIRWN0GH13N/W8zwQBymsDsHxDIHYVZK9KeQbxN
         v6P3MiR96ld7FXFDuhP33YI4HH14fmpmZwhdqb7MHIuSq4CDWkgom3ybdw/7W+rtD/hi
         PCt208rTEUCEjGkqUf7P+1fOwO14gjR9gnuT1bkwLEgtbK6eXUkIy7Kz9viu7WJ/QNTV
         v/RXJ8MGUmSGysv5BhIFBRU8WpU6rBKW5vtPKT2dbCSHNWirkehwMh4Jy6YLGjusl3YJ
         bSdA==
X-Gm-Message-State: ACrzQf3jzAzCdStqVhS4O+jpGqLz07Zl4/S7j0W/nAvmup3Em78E0NZT
        roVYLbgbSSFNHmqkt2+x9E/KdQ==
X-Google-Smtp-Source: AMsMyM5uUNefEbJyEombU5Pne5eh7gkeq3jt2zLQr7KmkPBO/aRdlwgIVriquyx1cLrEfTZDbw++2g==
X-Received: by 2002:a05:6214:f26:b0:4ac:7bf9:21d4 with SMTP id iw6-20020a0562140f2600b004ac7bf921d4mr28024259qvb.98.1664394785321;
        Wed, 28 Sep 2022 12:53:05 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id p14-20020a05620a22ae00b006ce60296f97sm3555778qkh.68.2022.09.28.12.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 12:53:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Date:   Wed, 28 Sep 2022 15:53:04 -0400
Message-Id: <66C933BF-D5AC-490F-81DC-601BE1DEEE60@joelfernandes.org>
References: <YzSK3LJst80JkP4q@hyeyoo>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <YzSK3LJst80JkP4q@hyeyoo>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 28, 2022, at 1:56 PM, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>=20
> =EF=BB=BFOn Wed, Sep 28, 2022 at 06:20:10PM +0200, Vlastimil Babka wrote:
[..]
>>>> Thank you for report!
>>>>=20
>>>> That should be due to commit 65505d1f2338e7
>>>> ("mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head")
>>>> as now rcu_head can use some bits that shares with mapping.
>>>>=20
>>>> Hmm IMO we have two choices...
>>>>=20
>>>> 1. simply drop the commit as it's only for debugging (RCU folks may not=
 like [1])
>>>=20
>>> Yeah definitely don't like this option as patches are out that depend on=

>>> this (not yet merged though). :-)
>>=20
>> But we'll have to do that for now and postpone to 6.2 I'm afraid as merge=

>> window for 6.1 is too close to have confidence in any solution that we ca=
me
>> up this moment.

I am ok with your postponing till then, gives me time to get other patches i=
n, in the mean while :-)

Thanks again for your work on this,

 - Joel


