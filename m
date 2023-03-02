Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371DD6A783E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 01:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCBAN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 19:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCBANZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 19:13:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A3E16317
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 16:13:24 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso1051185pju.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 16:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677716004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hnX+HdIFXVPvQ22LkGsYX5Bz0blCWB2FI4mBtVnh64=;
        b=mqUy9BFbn5pRWO3F4oA9v7oqc9ngHvcaayGbpRYNfzivE8FgEbes8epuR1+CcQpRdK
         SDvhsM9QKwOURjzE18GBiuNZOAF2YGyupCDFp4Z/TaU2vA+d3M4hWZ2tK7AWKVOmT8zV
         gNw4L9AZC0HEf3g4kK/ti7OYtJGyFIRciy6Pb92ZzVFjKhakZwSUqJm6Ne/iepTlLvUf
         /w5QmayhRJJL64+ZmUw7cuT9TnzYyizvK5cX+arbIq12cTf6M1MUisW2rIWyKa2n3tQj
         1ni9SBjCopSKLwjVbmEobW/JRLgVFOZppaM8/79c1Siff85R3yianlMuNRQP34rSUiOy
         eMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677716004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hnX+HdIFXVPvQ22LkGsYX5Bz0blCWB2FI4mBtVnh64=;
        b=kBnP/0HO+QMhovB1VWRlCiggiQcgOmJwjaTVWz9bZsld24kzNWMwDcSzIx+X26uq9+
         Ri9qW5np5X+bJBfJKlh/lJU7h9B+dNZBluf6CDxjCoMoODjEvha/Wb9WEEv7Zycqy5zp
         yeRpi9N9XDwJrmfvX2LgnzXlwJxELrQHn6VcdPpb32m8muhcoiyqlWDIqtdWkWfzSw70
         GnOHi12gcAAlcVTKomr4JRoUy8JzoyGYK9gZ1E6048Q/JY33r1umTXO1RcbJHorOPv4Q
         GhNhMK8HQ0SQEuJMJqvUoy8HcuWzgDgfq+V3ZRqKp01vlbOkVOjq7rHdrqvhkPVwJbec
         kITw==
X-Gm-Message-State: AO0yUKVs70L0WQmhrbr92fHQ4xOik1D1wqoFyBlPKNuqeTECc/ym9xuF
        4rkL/ZtayNJWx1PqY0zZeRY=
X-Google-Smtp-Source: AK7set/i+/8BY4tBNHAMPtYzDDlfogiQzHzSxE0LqP/t5YYwwiivr4mZ17nciB33TaPGzSuxnFcjog==
X-Received: by 2002:a17:902:d48e:b0:19a:a520:b1fc with SMTP id c14-20020a170902d48e00b0019aa520b1fcmr303047plg.14.1677716003802;
        Wed, 01 Mar 2023 16:13:23 -0800 (PST)
Received: from google.com ([2620:15c:211:201:a524:71b8:ce7e:745d])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c24100b0019a8468cbe7sm8521160plg.224.2023.03.01.16.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 16:13:23 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 1 Mar 2023 16:13:21 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/6] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <Y//qIR8tTZjVCFgD@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-4-senozhatsky@chromium.org>
 <Y/f2WvhNlwhsf2Cz@google.com>
 <Y/riPlQ2UK00WirI@google.com>
 <Y/6GAYJ4c9W0bPzp@google.com>
 <Y/7PAAIfI1pydXWs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/7PAAIfI1pydXWs@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 01:05:20PM +0900, Sergey Senozhatsky wrote:
> On (23/02/28 14:53), Minchan Kim wrote:
> [..]
> > > As of why I decided to go with defines, this is because zspage fullness
> > > values and class stats are two conceptually different things, they don't
> > > really fit in one single enum, unless enum's name is "zs_constants".
> > > What do you think?
> > 
> > Agree. We don't need to combine them, then. 
> > BTW, I still prefer the enum instead of 10 define.
> > 
> > enum fullness_group {
> >     ZS_EMPTY,
> >     ZS_INUSE_RATIO_MIN,
> >     ZS_INUSE_RATIO_ALMOST_FULL = 7,
> >     ZS_INUSE_RATIO_MAX = 10,
> >     ZS_FULL,
> >     NR_ZS_FULLNESS,
> > }
> 
> So we keep enum nesting? Sorry, I'm not exactly following.

Sorry, I meant let's keep separating them since they are different
things conceptually as you mentioned.

> 
> We have fullness values (which we use independently) and stats array
> which has overlapping offsets with fullness values.
> 
> [..]
> > > I can change it to
> > > 
> > > 	for (r = ZS_INUSE_RATIO_10; r <= ZS_INUSE_RATIO_70; r++)
> > > and
> > > 	for (r = ZS_INUSE_RATIO_80; r <= ZS_INUSE_RATIO_99; r++)
> > > 
> > > which would be safer than using hard-coded numbers.
> > 
> > I didn't mean to have hard code either but just wanted to show
> > the intention to use the loop.
> 
> Got it. I just wanted to show that being very verbose (having every
> constant documented) is nice :)
> 
> > > 
> > > Shall we actually instead report per inuse ratio stats instead? I sort
> > > of don't see too many reasons to keep that below/above 3/4 thing.
> > 
> > Oh, yeah. Since it's debugfs, we would get excuse to break.
> 
> This was in my original patch, but I decided to put a comment and keep
> the old  behavior. I probably will switch to a more precise reporting
> (per inuse ratio) in a separate patch, so that we can easily revert it
> without any impact on new fullness grouping.

Sounds good.
