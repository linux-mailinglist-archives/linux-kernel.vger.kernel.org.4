Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8552D674438
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjASVWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjASVVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:21:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AEE9FDF1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674162857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+iHY1JhHo7sNRnq5TCZlVvfIFAGkKRvvynfD4YQ8b9Q=;
        b=e9gw7VTO6MJ+RJsb5+3DY23c5/KTEBmw2oWCzF83bmh22SISlJJ0OBaJXuUOijNT2v4Uu5
        fkmFQHa8EIcTRoPrwcQQhd3v6X/SBt7eg5kgFK655+UYGCXvKuI1mC2BbWCH6XWLSuqPLR
        tHflVHy+g4TFumvMrpCqD2GuO4x/aZI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-118-qxwh9TsgPp6Uq0cMYe1fiQ-1; Thu, 19 Jan 2023 16:14:15 -0500
X-MC-Unique: qxwh9TsgPp6Uq0cMYe1fiQ-1
Received: by mail-qt1-f199.google.com with SMTP id q26-20020ac8735a000000b003b63165d87cso1526430qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iHY1JhHo7sNRnq5TCZlVvfIFAGkKRvvynfD4YQ8b9Q=;
        b=aeft5xwhRdWwvOOVL05o1E28z1YZW5sir8P+1lnznpk9CsXwJQS0s2KawQ/Uz4oGDM
         tlP1Mp7mM8QSyD5zZWKR2F0exUCJ38JoxOnaOpzxzRQEuNJdW3+4TAFFW+LvIP8rWywp
         mOv2rW310J99lNLWOdHgOjPylhIM0YJqisa0y9Bldjd4AlL5RMs2vkvNW6UjIqJXufg/
         ncWE826Qv00/YiACOf0ssUQ4Ado7Li+L3gwGxX7pgTfudv5SpKRWY95wffzVVIXzVDTD
         YCfdjCkAMpxittImmjEpddnP11iGS3htPvZ1W+117sKJ9RuzP8Mm59Atht16Dzqj4eTc
         Z+qA==
X-Gm-Message-State: AFqh2kr/armB9vq+TTOOFbPuInnkaichfnU1HovMWblfKyN8WjhdkO5O
        mshOfcBmjEz6nGGsE8Aw4qaiEpqJ//YkSFG0VDwpuLskQrtDbohwAfmeSQYq7kDcLyK5PZFtiCM
        EWcb1A4nVPOKrIMCvzq8sE6Dx
X-Received: by 2002:ad4:424f:0:b0:535:5a09:8312 with SMTP id l15-20020ad4424f000000b005355a098312mr3170020qvq.34.1674162855301;
        Thu, 19 Jan 2023 13:14:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt2pAh2PbL6ofFXjhTL8NCW+Ds/0+z/BXxNI16rcaTPJz1b1RTgCytbMYeE0N9f5zuezGPMrg==
X-Received: by 2002:ad4:424f:0:b0:535:5a09:8312 with SMTP id l15-20020ad4424f000000b005355a098312mr3169995qvq.34.1674162855013;
        Thu, 19 Jan 2023 13:14:15 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id q44-20020a05620a2a6c00b006fc9fe67e34sm10705407qkp.81.2023.01.19.13.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:14:14 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:14:14 -0500
From:   Eric Chanudet <echanude@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [RFC PATCH 0/1] fs/namespace: defer free_mount from
 namespace_unlock
Message-ID: <20230119211414.qfkh3hrmupcynrrb@echanude>
References: <20230119205521.497401-1-echanude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119205521.497401-1-echanude@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:55:20PM -0500, Eric Chanudet wrote:
> We noticed a significant slow down when running a containers on an
> Aarch64 system with the RT patch set using the following test:
> [...]
> With the following patch, namespace_unlock will queue up the resources
> that needs to be released and defer the operation through call_rcu to
> return without waiting for the grace period.

I did not CC:linux-rt-users. Resending with them included, my apologies.

-- 
Eric Chanudet

