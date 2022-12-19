Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45925650791
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiLSGcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiLSGcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:32:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEC0643B
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 22:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671431484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nc7qTxlmUz2RecvbE0nK25yMVU3Hb8QsUzmKfC5XdbQ=;
        b=g2mQmwYcDFLtuFhThVTqiF2olAV22HbYB07Qnoh3OpZXdJqW+BqKdkLnt0HggYVUBctI1/
        hOd81041uGUM8XgF69TOkYB9Dh5cufDlwH7VMEzMhmOn0ePQ6B0jiIMiKfU6aOrBxkjobk
        1BMhmPmODIhdDG63DA4waNOlz2XVMls=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-U000Ye98M2e47jpTej8Ujg-1; Mon, 19 Dec 2022 01:31:23 -0500
X-MC-Unique: U000Ye98M2e47jpTej8Ujg-1
Received: by mail-qv1-f70.google.com with SMTP id o13-20020a056214108d00b004c6fb4f16dcso5132257qvr.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 22:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nc7qTxlmUz2RecvbE0nK25yMVU3Hb8QsUzmKfC5XdbQ=;
        b=7qER85cQX4l00RsFcxYidHpZGmhqweYig7lMRINknUnB0ItecptH7n+Uhj70xwGO8W
         wbSQbqPxWETkC+O108szwQXR07fAtev+PgZxxCETGVRf1fDzReClB7SHH/8nbQV+rUCZ
         xE2yZKg/h+xIxGIDOCUUlSSq+OvLEXM5mHW/GPLSK4QObSTG2u3WcrxyF0xiNNEdJ+AP
         /TOB61dQWHtV2HUb4iy0iwiX2FUyitgZ+I2bqOQt+of0bIb9eRB1+HmgE9cSB7riM/Of
         aVe8XAKqSkwSVKfth1DOAko6ePafEFTvi6CS8B6Al6Owbxl+6/9lt5XSOdxXm1yqiBH2
         wq2g==
X-Gm-Message-State: AFqh2krZp/FIye6SJhZJ9Olr0z9SaeEDVoowZaepKBp7PA2JMGOMQc65
        Vi5K5V1z7lPYrUdo75BsJpHUbxm6DxTz8evRHA9SoeLv1/sCSJl1h9Ffp0fVUKGxjB+zveAcctG
        cyj7b80fGihLluUbfuhhKmygL
X-Received: by 2002:a05:622a:18a4:b0:3a9:72ea:5a5d with SMTP id v36-20020a05622a18a400b003a972ea5a5dmr23750542qtc.57.1671431482770;
        Sun, 18 Dec 2022 22:31:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsf9g6iVZ3MBQo8GBfcGOF/jhGlUYTzvh+tWoYw/gMab8c126S4XzxMGZdlF1YaJHg23LXvUA==
X-Received: by 2002:a05:622a:18a4:b0:3a9:72ea:5a5d with SMTP id v36-20020a05622a18a400b003a972ea5a5dmr23750526qtc.57.1671431482538;
        Sun, 18 Dec 2022 22:31:22 -0800 (PST)
Received: from redhat.com ([45.144.113.29])
        by smtp.gmail.com with ESMTPSA id d14-20020ac8668e000000b0039492d503cdsm5580246qtp.51.2022.12.18.22.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 22:31:22 -0800 (PST)
Date:   Mon, 19 Dec 2022 01:31:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        parav@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Message-ID: <20221219012917-mutt-send-email-mst@kernel.org>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
 <5b9efa3a-8a82-4bd1-a5b4-b9ca5b15b51a@oracle.com>
 <CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com>
 <25a18d7a-ebae-3647-32f0-14ad733118be@oracle.com>
 <38b9648b-8795-5b41-b06c-d13a1a6d5d3f@redhat.com>
 <ab5d903e-f78f-d304-24fb-de7ed73f1c55@oracle.com>
 <CACGkMEvJGfYRY5kF1WWKfT9irGLt8jfVK42g1Bp0UJWdMo_RAQ@mail.gmail.com>
 <e8cccd09-e0f2-b166-54af-96a17c57855c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8cccd09-e0f2-b166-54af-96a17c57855c@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 04:23:49PM -0700, Si-Wei Liu wrote:
> I can post a v3 that shows the code, it shouldn't be
> too hard.

I take it another version of this patchset is planned?

-- 
MST

