Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0077E73B6EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFWMMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWMMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:12:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C990F10C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:12:41 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76531f6ae6aso44345485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20221208.gappssmtp.com; s=20221208; t=1687522361; x=1690114361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hYgXaBuDuQz4XhegVOInfrO96Nj6JKl3/8qs2CoZU8=;
        b=UcL7ATu/2mu7eVRYdueydqXQqcCak/zhYdTmfmNHYx2Dp4W4lQJfGX4uw+VajV1i/o
         8olGZcCnVXJQ1ldLow6VRoVG7kXEoJ2rBvYRGrkZMQLYil0hR+GNt3NKhWyYMIaTUAGT
         twXRQzYgGjT7ZZokiZ4LmhPs+Wk8Q+9m5VLRPrTigdo4wWMSRZFgioZ93YM3vHVBUAi1
         Wz9X7ttaDxFrgJdJcNOzisCk/QdAaXNEbzKnqWpkUZPn0mciwmuA3RPKULl6FelcGHc8
         M5Jkqx8VMTVEMit75Zjr4BFx0saG5LnCjySckdtVn4wiuFAgH6aNP5o2OAVNoufyGoAl
         KJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687522361; x=1690114361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hYgXaBuDuQz4XhegVOInfrO96Nj6JKl3/8qs2CoZU8=;
        b=i0C2EOsiBNI8J+tU2o5d2oBRdDbl4mZSJcob7JyzTG8QPqy6cx+RXWMNctxxTI6p9I
         xQk9PROCJD8uIksUqg5DUU150sBqRXhSvX5AyLavKbWgJVNiUq0jkujQ3hz3w373zBlm
         gIn+DRqb6tmICZvVMKtEOFI8ryiHBObGsBg6OfTHDATxsDiP43LMT67cwaOmswXli04f
         qMTE8a19Z9wZtuE1Jd81qRkHu1pEBPfMiEwzDQkbiZAT5mJSp+ggUlj0RtjruVkiXTQo
         q9BL4DVENrXm0rg5O53wXC2k+voGFULB2LCSfpI7baGZlNb2UeVtychj92wIkZl7axVQ
         4N7Q==
X-Gm-Message-State: AC+VfDyFfJMWJVcfPhx/c1FakJ1MeNkkBxRifB2Z6BvQ2Sfm7bqro8kH
        An2k9LFBCetP/XSbZUFTbNZJQw==
X-Google-Smtp-Source: ACHHUZ5e/l/qcdN6RkqCE95IPyWinnT+Tv1jbwwtWh3J7HvnrVa9QRHcIxVH/arqj2G6ze7jG0cikw==
X-Received: by 2002:a05:620a:28c6:b0:762:212a:9f75 with SMTP id l6-20020a05620a28c600b00762212a9f75mr28418389qkp.33.1687522360933;
        Fri, 23 Jun 2023 05:12:40 -0700 (PDT)
Received: from elrond.bobcopeland.com ([142.189.78.26])
        by smtp.gmail.com with ESMTPSA id x22-20020ae9e916000000b007653cc036aasm1366344qkf.48.2023.06.23.05.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:12:40 -0700 (PDT)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id 3A26EFC0153; Fri, 23 Jun 2023 08:12:39 -0400 (EDT)
Date:   Fri, 23 Jun 2023 08:12:39 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 51/79] omfs: switch to new ctime accessors
Message-ID: <ZJWMN/ccJ692YKoB@bobcopeland.com>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-50-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-50-jlayton@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:46:04AM -0400, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Bob Copeland <me@bobcopeland.com>

-- 
Bob Copeland %% https://bobcopeland.com/
