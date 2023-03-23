Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3106C7059
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjCWSic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjCWSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:38:29 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B04B19F12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:38:28 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j10so6805045qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1679596707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvIeSIrQKG8SHkST/JtP9EE3wX1+QUI59EJ6DH7PrBw=;
        b=WoXiijd0hLJ4NYVKK8kcRZ0t941gXJBPo07k7ESw+2J8hvFCms4zP8exV1rl4T/Eag
         tTiX392QlhyGZcVBjA8mJcW/+3xVGzs4v5q7Hynia2hq0Wj4+cJT4fxlcngIlFTLTOpe
         1IMrDvq5Uj7NDRtZNgbutjjT9viExeNBVYY/gUhj/wEN2BbCZq8I5weraLjYwmnKjG1Q
         46OG+LU9lE7XVVluaUbUu1KSrW473lwBfv4D9DSFDKHv9qaeCD/fFpXevinpsPWOk108
         zBhb81O6AimzzmUpEtpQh0hz4SC2+5MTJT4XxVHJYlCxXvXulBpVCxAyZhx/Ofx/3agk
         9SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679596707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvIeSIrQKG8SHkST/JtP9EE3wX1+QUI59EJ6DH7PrBw=;
        b=kbe8dN/hEH+A25Fx4NUxFpYNDxYECAFScxrReaYWZ0SHLnYV2TO61PxCPVe/X5Npy2
         ghOCQnfpTicvw6yYVl0blME7mmw0c06V7cLEuX/0NaV1rbOTUeLQrcCA11Oqe4oMUVpH
         d/usw+pnG0RcCxRFs7HZFwUA965RLPkFfZFOiLDYGLE/kVZgQHGSXka2nr9LPulZj5OA
         Tz8gTX6blkKgxvqUCwnvGFwofBGAsK7oGa820hYQ2xsQ2YRV0vbo81ay4E6RyqudNp68
         GdXobbScP0EFAX0Mgk4p/iBP5RPZoW88ja502uuxvOfB/gVfP3MIEgFcuEOe8hDkq6SB
         CqIQ==
X-Gm-Message-State: AO0yUKWk1pFUaC6kxBqvAJ+3AAFyzKIc3LiJJpbwFPM9YjOr8S584cn5
        tlbaI/fOodMQaWxzIUQHneXQvKiJ9AlsiiKcE8VHUQ==
X-Google-Smtp-Source: AK7set8WOs445stSX8tNyOamx7phrjm8/MEm5N3QZAmW7gYzKJjBfnl97PSTj2l4hJPKIUBdO8ajF+aavcwTu0I6VHY=
X-Received: by 2002:a05:620a:454e:b0:746:a161:7dc2 with SMTP id
 u14-20020a05620a454e00b00746a1617dc2mr21486qkp.1.1679596707263; Thu, 23 Mar
 2023 11:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230323171904.14444-1-krckatom@amazon.de>
In-Reply-To: <20230323171904.14444-1-krckatom@amazon.de>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 23 Mar 2023 14:37:50 -0400
Message-ID: <CA+CK2bDEPvQnMqv7R9JZybsNWbaMdHOPA0vKs501Txsu2OewKQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Be less noisy during memory hotplug
To:     Tomas Krcka <krckatom@amazon.de>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 1:19=E2=80=AFPM Tomas Krcka <krckatom@amazon.de> wr=
ote:
>
> Turn a pr_info() into a pr_debug() to prevent dmesg spamming on systems
> where memory hotplug is a frequent operation.
>
> Fixes: 966cf44f637e ("mm: defer ZONE_DEVICE page initialization to the po=
int where we init pgmap")
>
> Suggested-by: Jan H. Sch=C3=B6nherr <jschoenh@amazon.de>
> Signed-off-by: Tomas Krcka <krckatom@amazon.de>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
