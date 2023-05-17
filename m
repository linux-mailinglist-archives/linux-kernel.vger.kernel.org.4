Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5DD707170
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEQTDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQTDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:03:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A95940CF;
        Wed, 17 May 2023 12:03:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so1141353f8f.2;
        Wed, 17 May 2023 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684350228; x=1686942228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIHIVW8gO6F1xr1p20GKmGuw8up3x4oHuRxQsyQ6iNE=;
        b=Toxx3u+ltCr+6yVmQw9zLHZroTZYBi/VScrv95T0rkmXFD6RaiGcapaO8KulcsdGcy
         WFsYktRbkl9F/m5gDehlChKWENvW877HTYoeOYaG9fsA6bQL76MJL5xK9HeTO6W68mOe
         OcC90z+ZhNlhYvrCeEJ3fVcJha7OHLoRQfe9Av/q4JAWOAdxJYVOLm6y+5c2wWXYAkbJ
         CDCkSs8Ai3bm21oOK+8ntwbftl1cEZhH+HwPH/gR2tZ8HCcNfmebn73EEXff559s8iWE
         KQKor8i8VKh/8TSzlA1Yksop5JlPQcOYg4oLi8yid/SHY6EOFbEBstDd8T1HGEO9V3Ic
         MpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350228; x=1686942228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIHIVW8gO6F1xr1p20GKmGuw8up3x4oHuRxQsyQ6iNE=;
        b=B5kAofDd3xWHQ64ngGvKmh4OpgDgcvIabp4zoXxWMCdXmD15bLcX0EOQmjZi+hCPto
         vaac01x+AGkcwaHW5BJrHLJ7zu1/Mg+X870B402y3gIGCcqWHmnL9vb/T1T4oXhbULeQ
         QBRik+Fv+gonUIXhYhYFaXecS2fV6jtvK6NLmGoTojE1opggcCV798i5mbFanMhmWP1f
         Tzi11iyappLyg5q996JjTcghm5fzrrI56/Pvh17je8reCy1W2ex7+VTbBc/IdLhATEs8
         OhkcDQfEeI++J5/2WQI//lAATq7mNo2aX1Pq4qfGgAKtvGJ21p2hk/5o79+Vu7WxH8H4
         6TXA==
X-Gm-Message-State: AC+VfDx3yAds1JRJKMPAno9h9LP0CT/6+/0z0+XXXL/AVKABdws8tX22
        joTQhKjWsvgtkCX+GRccdm8=
X-Google-Smtp-Source: ACHHUZ7Xjapcqcmf0dflGZ94yYjm1mZ8H+pqYGq8xaMmYW14XjHTELofvkhYd2oZNOQztZIVg9P7CQ==
X-Received: by 2002:a5d:4577:0:b0:307:a4ee:4a25 with SMTP id a23-20020a5d4577000000b00307a4ee4a25mr1462127wrc.28.1684350227502;
        Wed, 17 May 2023 12:03:47 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0030903371ef9sm3529304wrv.22.2023.05.17.12.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:03:46 -0700 (PDT)
Date:   Wed, 17 May 2023 20:03:45 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts
 part of vma
Message-ID: <b24631a2-9a5e-4d87-a88f-72365d626995@lucifer.local>
References: <20230517150408.3411044-1-peterx@redhat.com>
 <20230517150408.3411044-2-peterx@redhat.com>
 <4a68aee6-68d9-4d17-bb7f-cda3910f6f1f@lucifer.local>
 <ZGUe9f/niO03t7lC@x1n>
 <99566f92-9b97-4b2b-b75b-860532e851fd@lucifer.local>
 <ZGUi79uCvmDLuh0i@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGUi79uCvmDLuh0i@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:54:39PM -0400, Peter Xu wrote:
> On Wed, May 17, 2023 at 07:40:59PM +0100, Lorenzo Stoakes wrote:
> > On Wed, May 17, 2023 at 02:37:41PM -0400, Peter Xu wrote:
> > > On Wed, May 17, 2023 at 06:20:55PM +0100, Lorenzo Stoakes wrote:
> > > > On Wed, May 17, 2023 at 11:04:07AM -0400, Peter Xu wrote:
> > > > > It seems vma merging with uffd paths is broken with either
> > > > > register/unregister, where right now we can feed wrong parameters to
> > > > > vma_merge() and it's found by recent patch which moved asserts upwards in
> > > > > vma_merge() by Lorenzo Stoakes:
> > > > >
> > > > > https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> > > > >
> > > > > The problem is in the current code base we didn't fixup "prev" for the case
> > > > > where "start" address can be within the "prev" vma section.  In that case
> > > > > we should have "prev" points to the current vma rather than the previous
> > > > > one when feeding to vma_merge().
> > > >
> > > > This doesn't seem quite correct, perhaps - "where start is contained within vma
> > > > but not clamped to its start. We need to convert this into case 4 which permits
> > > > subdivision of prev by assigning vma to prev. As we loop, each subsequent VMA
> > > > will be clamped to the start."
> > >
> > > I think it covers more than case 4 - it can also be case 0 where no merge
> > > will happen?
> >
> > Ugh please let's not call a case that doesn't merge by a number :P but sure of
> > course it might also not merge.
>
> To me the original paragraph was still fine. But if you prefer your version
> (which I'm perfectly fine either way if you'd like to spell out what cases
> it'll trigger), it'll be:
>
>   It's possible that "start" is contained within vma but not clamped to its
>   start.  We need to convert this into either "cannot merge" case or "can
>   merge" case 4 which permits subdivision of prev by assigning vma to
>   prev. As we loop, each subsequent VMA will be clamped to the start.
>
> Does that look good to you?
>

Looks good to me, thanks for taking the time!

> Thanks,
>
> --
> Peter Xu
>
