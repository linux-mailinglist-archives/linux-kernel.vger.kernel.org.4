Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63246E9D46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjDTUet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjDTUer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:34:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E612D5B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 13:34:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63d4595d60fso9947474b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 13:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682022886; x=1684614886;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBKSlGmTPj0SpwuhNR71Xgy9umtibtA7xDNMtVxgSZo=;
        b=Q0csoKghi+ruQlPyX1y/gcn7KGo2Sb6HcZ1kR3OStBCci/uXSBawC0zCV6+KEIjFju
         DXbaWF/3UPtHsgF7LMNYJSSKyAJho75bVOzpS80vy31G25q6aAvn9clgT3SNad88fOEN
         OzZcTmBimupR7ShXRNRpkdSCRC8u5WaXSfiSxoUnYrvTIzfBydGWg4iYmygjkayFyjUa
         IikTsu4roxtYas+jAjvylrBoLfKSfA4nkvMNbURR6pnwQchimvQFjEHSSPVeGi4uHUTs
         Ta7oNclQsnOZM07cG4TZTx62AVfkx+gbWzONzVpRJNWmQmjKCTMQ4sBezodLvV+5O8m8
         DOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022886; x=1684614886;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBKSlGmTPj0SpwuhNR71Xgy9umtibtA7xDNMtVxgSZo=;
        b=hy4eiiSGZ6vwdzFfKh9Mn9H3e0/AAdMdxXPVvmn5iUVf4+zDRbQMqVBoEBDBnG5mQL
         pJVhIn7Hv7NdNTAJdjqzVrpRyNLZUekIV+7mQtoeem9DCpRO1VxWjN4Da4vi85xG8ewP
         KUYlODXQHwu8B5AEvH2+AS5nO5+FBn1iWbOgfWBYA/PDMDVK0XMgK29PmuCZwc49Ysfr
         +xTbZ0234YgMKFqVYyU0DMiH8bcrKI1BkXaHKHtvAUcVezASk3Wh36qEqGfU4IRbmKwW
         7I7sGMRP0grC+Z0IUJEHos5gKMx1ScH4jysgDLKbZuTN+gEsXHpXw+K2hK5024+m4nv9
         vFvQ==
X-Gm-Message-State: AAQBX9elqQ9CuxaLaU/QlGtFZCCgWnrCgPefvGZLj9vRhRAoGrWFuNTC
        g0bvKJ/ciy9iWoMb1nBQwZzamGUeS+F+QM/NcyvBXg==
X-Google-Smtp-Source: AKy350Z5gXN5upUeBRT71FK0ExW+0W0up3cDxLpY2o4m0aVRkyyxYgT0FlYgCfa0ekh0BujRfWooMA==
X-Received: by 2002:a05:6a20:3ca4:b0:ee:444a:ce1a with SMTP id b36-20020a056a203ca400b000ee444ace1amr2719266pzj.30.1682022886197;
        Thu, 20 Apr 2023 13:34:46 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w4-20020a627b04000000b0062cf75a9e6bsm1619660pfc.131.2023.04.20.13.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:34:45 -0700 (PDT)
Date:   Thu, 20 Apr 2023 20:34:42 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     linux-mm@kvack.org, surenb@google.com, tkjos@google.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Using page-fault handler in binder
Message-ID: <ZEGh4mliGHvyWIvo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to remove the current page handling in binder and switch to
using ->fault() and other mm/ infrastructure. See, we currently allocate
and insert pages manually into vmas, so dropping this boilerplate code
seems like a great idea to me. Before starting on this though, I could
use some pointers on some of the implementation details.

In binder the messages are not buffered. What happens is that a server
task mmaps a region and then allows clients to write their user data
directly into this _remote_ vma. This is currently achieved by caching
pointers to every page allocated in the server's region.

Instead of caching page pointers, I believe binder could make use of
get_user_pages_remote() and trigger a page fault as needed. Basically,
implement something similar to access_remote_vm() but that instead does
a copy_from_user(). However, I don't see many in-tree users of these
routines, so I wonder if I'm overlooking something in this approach?

One more reason for the page caching in binder is being able to free
pages from the shrinker's callback. Unused pages are added to an LRU
list and we manually zap/free them when they are reclaimed. It is not
evident to me how can binder mark a range within the vma region as
reclaimable?

Any pointers are appreciated!

--
Carlos Llamas
