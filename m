Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062C973E60F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjFZROm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjFZROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:14:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF910C0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:14:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b7f223994fso17439395ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687799670; x=1690391670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJE3tSPsFpi5soQXMUzNnloIMHvsPIIolw53mxwns/k=;
        b=X7exCkB7FESNnh5FVK7yzhD7cjO47NzhVHwYl0wyQkWk3pEDoVI0Wad4El7oQyei8l
         NSFjHSBjGT4hO4jV5z6c/xRhWjALKAb+oQMxEvYUv7F+H9gt/3ifVSIIvc3V1gXIdwv2
         TCzxZZB0ZE+o+uICefeMP+pIwbVqlx44/CU10m8+8VD/Yykuj+zHwAtLq9TTjM2bzsN8
         OH9y74YgURbTBGar1UsDo4i/DxKzmSJsNyEen2GmpGwIQMTFSN6ucMKQcQ3/d8CDWlia
         TYFXztJDwYuVCvZlYXQhms9WLBxlH0sW6hZNKn2zN+j44Unwm84OCqXEaY1ztUXrht3Q
         UQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687799670; x=1690391670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJE3tSPsFpi5soQXMUzNnloIMHvsPIIolw53mxwns/k=;
        b=jfG1FglfMqCE0C53vA22d5zc9IxqNPGwA6QM+JuW0fWmjBX57oPo4lDkWajMGjSjs0
         2AyAJBJbf8GvqD1JZDlcS9dS5GoV5SI4XqAqnwdQKC0vJ2NIyd03Cs/4KRbdN+eLJa10
         +0GvGJYq51Tk3//KYx1v50UzPN+I8AeLWk60KB/GCwL8kX5yNLQlio9vL3RdQBNkzJ3P
         PRtaNZZgrrPOGxq+ozQ7A8/2yMxYycaYgFUNmUwA1pIaEeAV5VrGi0Z1sbwQsJJB4tvN
         b2JodZZ+2xoCAkYJK/MTyXoOI2RRCHfHZAmYRyKqoh5edHRG9MGdD9Um7tww69DHcunC
         EIXA==
X-Gm-Message-State: AC+VfDw7XrfMmP8l3C7OtFBeiYyOSg3i4FvKmQMprt781braywdhYelt
        3D8IppaFmRcomaYfh/7vV/8=
X-Google-Smtp-Source: ACHHUZ6HKcGFJgmK2JUvXdJbcIO0GQqA64SKzjmKIGrMO1LYZe5tnrfR7ies+o+7MbrClkiB2J0geQ==
X-Received: by 2002:a17:902:e545:b0:1b6:99fa:1ccb with SMTP id n5-20020a170902e54500b001b699fa1ccbmr9866246plf.32.1687799670397;
        Mon, 26 Jun 2023 10:14:30 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:9abd:c54f:4c3a:e10a])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902868300b001b04b1bd774sm4449254plo.208.2023.06.26.10.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:14:29 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 26 Jun 2023 10:14:27 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 3/3] zsmalloc: remove zs_compact_control
Message-ID: <ZJnHc8ynABmyI7sE@google.com>
References: <20230624053120.643409-1-senozhatsky@chromium.org>
 <20230624053120.643409-4-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624053120.643409-4-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 02:12:16PM +0900, Sergey Senozhatsky wrote:
> From: Minchan Kim <minchan@kernel.org>
> 
> __zs_compact always putback src_zspage into class list after
> migrate_zspage. Thus, we don't need to keep last position of
> src_zspage any more. Let's remove it.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
 
 Thanks for picking it up, Sergey!
