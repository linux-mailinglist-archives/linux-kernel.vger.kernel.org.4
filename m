Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2746E9B01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjDTRmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjDTRmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:42:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6203170C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:42:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94eff00bcdaso97967466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682012529; x=1684604529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOShlAmW5KtWyt18VPabl3AojpTzB/52zpa39oAofYI=;
        b=YmddgtRtW8ICTes0+dab7w6Oem6Kx16VyROeBvQ/nYxGBP5/ZMHSlacbBwi0Ijvq0Z
         HBwAMMZMA69v0M6/JecoGitZ1Z+oEhnr95tNJhaUhyTkNIF355Sm7sagw0sExkPzRaWQ
         YaW0R2WKdh8uu6dv0MaNqSyH0IBqw4UGq2EDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682012529; x=1684604529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOShlAmW5KtWyt18VPabl3AojpTzB/52zpa39oAofYI=;
        b=Y87AAKjaaet6jqnG5huW6P5OvETVRMrNT+1QRzCYxJmEiIVXGd/WnlesWq6gdx+OsC
         LGl7T8xYPoVqTFS81+UQ+G0JQhkEVt79TUH0GHRrw/w+c1VO06JOrBbPQqH7LV38f5se
         VGGDnGwW8f+fdmFg/HoWs+Vrp2zPAgD7y1LfW9UnO8odMHGCBd5SUD3EbfcpVMS9CU8L
         Hsz4HxokISWpX334/BL6H1IgRWqYfuV7kise2p11+kYFi8jhcBI/wgMBNTOjzN3SKTaZ
         GDkNa/EZeS+qTrYjuvb72Xice6taK961Bj4wl1KiptrQnTnV9AlHgHFBbxqDc7LvDEw9
         cKpQ==
X-Gm-Message-State: AAQBX9fTeLn5dnzZ4M3WvxhBND1tyV5gkxLvoKJUSdUiw7V++ofocxnK
        ypuzLqdvU5jbDs5G8Ky5SuI8US6OEE2oS0+UAqiaqQ==
X-Google-Smtp-Source: AKy350auT20t6FOb+4AgjUmWFcoyThBQnArWZX8Nl6LqCPFqucTjIuxXlPmzUnAM2Xrg1Nu+DICIWX/ywGGGDp/EAL0=
X-Received: by 2002:a05:6402:7d8:b0:502:2265:8428 with SMTP id
 u24-20020a05640207d800b0050222658428mr2195635edy.38.1682012529194; Thu, 20
 Apr 2023 10:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-1-sarthakkukreti@chromium.org> <20230418221207.244685-2-sarthakkukreti@chromium.org>
 <b74cc3d8-bfde-8375-3b19-24ea13eb1196@acm.org>
In-Reply-To: <b74cc3d8-bfde-8375-3b19-24ea13eb1196@acm.org>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 20 Apr 2023 10:41:57 -0700
Message-ID: <CAG9=OMOfpJHB3HbjK46_bh_P6b4vdSfBt1Q39ukuKhZzyscnow@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] block: Introduce provisioning primitives
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropped in v5.

Thanks!
Sarthak

On Tue, Apr 18, 2023 at 3:43=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 4/18/23 15:12, Sarthak Kukreti wrote:
> >       /* Fail if we don't recognize the flags. */
> > -     if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
> > +     if (mode !=3D 0 && mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
> >               return -EOPNOTSUPP;
>
> Is this change necessary? Doesn't (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
> !=3D 0 imply that mode !=3D 0?
>
> Thanks,
>
> Bart.
>
