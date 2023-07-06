Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B074A2CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjGFRHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjGFRHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:07:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1405C171D;
        Thu,  6 Jul 2023 10:07:07 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53482b44007so564571a12.2;
        Thu, 06 Jul 2023 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688663226; x=1691255226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gqf08F2Bb0gKm26BFhXQKsKBfR3DKmsKnAhhQeDa5Qk=;
        b=Fo8AeDyb6BW9HEaJ/jBmNsnqzldH2H4Pf6eF68ekBCoYeFRmxlNHwTiMBUpLbs8G0J
         fl+zhYfDs+uYNTP+5nqs+s3QORA0oeI0ferfZHZZzs/B6BjWZhMz4gKt7/izlHj35OLN
         6UcEbZKI5sZD/S+g9+txl3AEAy0FyJfXZHkdOKCg4JpiCDmpLovpBvlhwWbMkYqQ8snT
         RPevshBLhoXUeasZIaUtKLkSJgOU4mqS3vtDKnULJn6TQFsYokEdltnCjlTLADZxno8D
         YI3za+NttUc2fcOVQA1p0WKd6LsuYbPVKP2H84cT7lcTt50CO5F77iaCDmvxngNa94+Q
         pnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688663226; x=1691255226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gqf08F2Bb0gKm26BFhXQKsKBfR3DKmsKnAhhQeDa5Qk=;
        b=OM1IfqY+i4vQ8/yEjtlfL2Et4kx1p4JNlKl2+njphD2ax6VeDAq8m7+V2t9y+WMU4I
         BtNbifnv9Lzpd5+yNyvnTttn7L7/Rm2ebzVcvlCJbg75HSer8UqIJLtq6yUpnsOi1LJz
         cfzDinuyLACWOt7/SskLIEywBD7R2GSr8xMc2AV7YAgQQ1uwA8u57JOkjiJfNXtok9Hs
         wqyBTc0LnU42QoTABgaQs45MS/3n+KMLuhC6p9KKWpzPFugihHk+nl5Nh78OEI7pMrNq
         v7NcC8lEQwURMhcEaspBTZSFOAzcXSth5KUqptr5Ubhx0l2ysXLFMCBTRDBulEXYx0gd
         COTg==
X-Gm-Message-State: ABy/qLbo+I+WL9OtdZqLfXPsunL/ouRv0jAoBmQekaxvK+8tCPbFDAda
        fdPPZwZI5GtIJPs63d5i1PNBblr6FidRs7J+T7k=
X-Google-Smtp-Source: APBJJlEwtM6589fW7lB1xzRgrrhcXFmcYSJAgNfP6FCGx9CqmSV9BS66UFTiCE4qQZ3HtMDmhV4F6kydZF+iDiCQPsc=
X-Received: by 2002:a05:6a20:394f:b0:125:4d74:ac77 with SMTP id
 r15-20020a056a20394f00b001254d74ac77mr2205076pzg.42.1688663226296; Thu, 06
 Jul 2023 10:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-4-aleksander.lobakin@intel.com> <CAKgT0Ue+VvnzNUuKiO1XFW6w3Ka9=SSfGBP_KpkbvR6uzqvg5A@mail.gmail.com>
 <6310c483-8c6e-8d34-763a-487157f6ff0c@intel.com>
In-Reply-To: <6310c483-8c6e-8d34-763a-487157f6ff0c@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 6 Jul 2023 10:06:29 -0700
Message-ID: <CAKgT0UfLBmzhshM5ZsvLaBwGtv2AvXA3n+kbn9FtBWTCocsiDw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next v4 3/9] iavf: drop page
 splitting and recycling
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-kernel@vger.kernel.org,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        David Christensen <drc@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 9:46=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander Duyck <alexander.duyck@gmail.com>
> Date: Thu, 6 Jul 2023 07:47:03 -0700
>
> > On Wed, Jul 5, 2023 at 8:57=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:

[...]

> >> @@ -1431,15 +1303,18 @@ static int iavf_clean_rx_irq(struct iavf_ring =
*rx_ring, int budget)
> >>                 else
> >>                         skb =3D iavf_build_skb(rx_ring, rx_buffer, siz=
e);
> >>
> >> +               iavf_put_rx_buffer(rx_ring, rx_buffer);
> >> +
> >
> > This should stay below where it was.
>
> Wait-wait-wait.
>
> if (!skb) break breaks the loop. put_rx_buffer() unmaps the page.
> So in order to do the first, you need to do the second to avoid leaks.
> Or you meant "why unmapping and freeing if we fail, just leave it in
> place"? To make it easier to switch to Page Pool.

Specifically you don't want to be unmapping and freeing this page
until after the !skb check. The problem is if skb is NULL the skb
allocation failed and so processing of Rx is meant to stop in place
without removing the page. It is where we will resume on the next pass
assuming memory has been freed that can then be used. The problem is
the skb allocation, not the page. We used to do the skb allocation
before we would acquire the buffer, but with XDP there are cases where
we aren't supposed to allocate it so it got moved to after which
causes this confusion.

> >
> >>                 /* exit if we failed to retrieve a buffer */
> >>                 if (!skb) {
> >>                         rx_ring->rx_stats.alloc_buff_failed++;
> >> -                       if (rx_buffer && size)
> >> -                               rx_buffer->pagecnt_bias++;
> >> +                       __free_pages(rx_buffer->page,
> >> +                                    iavf_rx_pg_order(rx_ring));
> >> +                       rx_buffer->page =3D NULL;
> >>                         break;
> >>                 }
> >
> > This code was undoing the iavf_get_rx_buffer decrement of pagecnt_bias
> > and then bailing since we have halted forward progress due to an skb
> > allocation failure. As such we should just be removing the if
> > statement and the increment of pagecnt_bias.

The key bit here is the allocation failure is the reason why we halted
processing. So the page contains valid data and should not be freed.
We just need to leave it in place and wait for an allocation to
succeed and then we can resume processing.

> >
> >>
> >> -               iavf_put_rx_buffer(rx_ring, rx_buffer);
> >> +               rx_buffer->page =3D NULL;
> >>                 cleaned_count++;
> >>
> >>                 if (iavf_is_non_eop(rx_ring, rx_desc, skb))
> >
> > If iavf_put_rx_buffer just does the unmap and assignment of NULL then
> > it could just be left here as is.
>
> I guess those two are tied with the one above.

Yeah, the iavf_put_rx_buffer should be left  down here.
