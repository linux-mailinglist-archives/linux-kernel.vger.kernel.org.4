Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA6E6BBCE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjCOTEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjCOTET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:04:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED41A4BD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:04:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m2so5473584wrh.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678907055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3ItpPSFI5C02+SOhKmoKROxDDoqOzc2Jscl1oh6KLE=;
        b=B168okNksncib2FAyRFUbb0otPkudA/iQibHKXhRZuLYhTL7qtMP8IIKpa+X3BgwXp
         dVeSzyfYfTXUsBUuouNzgaMdBAFLFDuQBSoBH1t/8WITy2VP1CMmeNryYhNLGlvnsGkh
         jx5deHb8wZ1oTD3TaWYK4XRHMblq/TuJwnjZZOM3eaUbHqcJwM8HDAXiUs5BQzj6kb3X
         ZwaALbPklR8HZuR5yJvPG/gHZdjnZ9mVNgdFGhjKXHi48CgDFpN7Ym5L1X5KOzMWZPDE
         TfaDhr1h6CjV5cPkd9hG2PXBIzkSTSu9I7l5sKyi3yGJi46QoEqBYG9v+GmZMm1SDSnC
         oqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678907055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3ItpPSFI5C02+SOhKmoKROxDDoqOzc2Jscl1oh6KLE=;
        b=kOvDFieicNDSWo1/JXgxREu5uyMOTB7D94glkFx/G4tF96A5s5nMKUnTu8v6a3ePSv
         CyZB68gcmpuXCHWQxRkjHyQWaDAS4swnQCo0y49czPJ3DarAYtlUOi2vdcU4zNFs0WrX
         QZOpH4sQIe/yFKQG++Hia2oHNrOTMfKKTIr3F75dAcX7nNYgYHOO2Q4TH9H09lf4qvCd
         LBfPhDxbpsF3ToAbLcsW5F6Ymp/JI5knu/jMQMcbOSh1pvnpwIiWT91UO8axfGpV9Qk1
         FRhcMhgnshsYsKyYA+arUS07SBwdmhX7ygIrh2ndKP4dXin3G8mUJsvClVhIkzaGDFr/
         Ndlg==
X-Gm-Message-State: AO0yUKWaKAJpU97J88FV4H3bbrWLdNrkuQDKKvqBkjL9HUjqmajymBXx
        OhTI/5jxmlubyPvTN86Zne4=
X-Google-Smtp-Source: AK7set8PBYRJXD6Xc0UnY7Syh9epJEtqi+H+nuqJliUsbbWuAVfb6HC/a3hK5ICHPQoBg8S1TXgpPA==
X-Received: by 2002:adf:cd0e:0:b0:2ce:a0c1:bcaa with SMTP id w14-20020adfcd0e000000b002cea0c1bcaamr3015494wrm.9.1678907055164;
        Wed, 15 Mar 2023 12:04:15 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id e18-20020a056000121200b002cf1c435afcsm5297568wrx.11.2023.03.15.12.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:04:13 -0700 (PDT)
Date:   Wed, 15 Mar 2023 19:04:13 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 02/10] mm/mmap/vma_merge: use the proper vma pointer in
 case 3
Message-ID: <f60110e2-2b91-4233-8f00-65682fc7907b@lucifer.local>
References: <20230309111258.24079-1-vbabka@suse.cz>
 <20230309111258.24079-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309111258.24079-3-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 12:12:50PM +0100, Vlastimil Babka wrote:
> In case 3 we we use 'next' for everything but vma_pgoff. So use 'next'
> for that as well, instead of 'mid', for consistency. Then in case 8 we
> have to use 'mid' explicitly, which should also make the intent more
> obvious.
>
> Adjust the diagram for cases 1-3 in the comment to match the code - we
> are using 'next' for case 3 so mark the range with XXXX instead of NNNN.
> For case 2 that's a no-op as the code doesn't touch 'next' or 'mid'. For
> case 1 it's now wrong but that will be fixed next.
>
> No functional change.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mmap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 0a8b052e3022..1af4c9bc2c87 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -857,11 +857,11 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>   *    mmap, brk or    case 4 below       case 5 below
>   *    mremap move:
>   *                        AAAA               AAAA
> - *                    PPPP    NNNN       PPPPNNNNXXXX
> + *                    PPPP    XXXX       PPPPNNNNXXXX
>   *                    might become       might become
>   *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
> - *                    PPPPPPPPNNNN 2 or  PPPPPPPPXXXX 7 or
> - *                    PPPPNNNNNNNN 3     PPPPXXXXXXXX 8
> + *                    PPPPPPPPXXXX 2 or  PPPPPPPPXXXX 7 or
> + *                    PPPPXXXXXXXX 3     PPPPXXXXXXXX 8
>   *

I'm glad you're making things more consistent and what you're addressing here is
a real clanger, but these diagrams while great to have do definitely feel
quite confusing even now.  But that's something for a future patch!

>   * It is important for case 8 that the vma NNNN overlapping the
>   * region AAAA is never going to extended over XXXX. Instead XXXX must
> @@ -978,9 +978,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma = next;			/* case 3 */
>  			vma_start = addr;
>  			vma_end = next->vm_end;
> -			vma_pgoff = mid->vm_pgoff;
> +			vma_pgoff = next->vm_pgoff;
>  			err = 0;
>  			if (mid != next) {		/* case 8 */
> +				vma_pgoff = mid->vm_pgoff;
>  				remove = mid;
>  				err = dup_anon_vma(next, mid);
>  			}
> --
> 2.39.2
>

This does fix a big incongruity in that previously everything but vm_pgoff was
relative to next, while in the non-8 case mid is equal to next anyway.

Good, clarifying improvement!

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
