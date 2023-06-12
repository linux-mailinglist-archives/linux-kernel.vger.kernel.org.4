Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B137272CF09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbjFLTLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbjFLTLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:11:35 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D642AED
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 12:11:34 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f9d619103dso47201cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686597094; x=1689189094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8g7vLhL7EFYkxF/CEAE3cAlq8J+ckJkpg1IYnErrxc=;
        b=TCh+0bftHfLk+DgBwOYgbe9CIcKn6q4xqoiF2jA02xQU9IfV1Qr8625n9sKj/azgjD
         anC61FVDat8ahe2+p1Ft19Fwn5RNCDpWhbht5YS5tQWj48G883TfUSfcWxuyrIl/+Hb6
         e9THiUz7QhkU6G5YM8fjDlc2rcd/iNLMlmhAARiz4cGv/wu3EpSl/YbRA5HXPG4tvLej
         3TU17lbMkt7MqIGH2cMbVdXGDd7nrz4ZK5resRc8aUUGwr5T7ze7XQnqO0qNJnOocI0Q
         zfSxEQ8ky5T6Te0AIIKOdbuWe7DMrY1RzZRH5cOqhVLpVY6DhKEnDwakA+RKDNM6QkMB
         NeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686597094; x=1689189094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8g7vLhL7EFYkxF/CEAE3cAlq8J+ckJkpg1IYnErrxc=;
        b=Yu7Ur8VhU/w0S7JUwXuYdr8WOKUEHVY/DLdTQZ8i9fkuVq7FWrAv7zD3ehGQGyzzQO
         liHHJDFlRUUy6ka/wLSn+KiNBNbhCa7yNkQ0zatBUrNuBGfkPnh9VhXLjhDwnRB17gzP
         JFAXoaBYYB4kFHWMQwDTmsCHrtyvyuSPbBQ5D8O9FJGthkjjqIHDQtkAWjbVUKKgZthI
         iujnRzOWOssmc0aLtTcsZh0TOPhGoDgrpJAKweV48deGdgdJB8D4m3hTOHHx2fPr1YU0
         nbO8SdpIO5fFv3GFzVKybzyfPlUAdr5wRnNKBW9oJAxHzX//TTesnozxy+QT+vyLO+Zm
         ByCA==
X-Gm-Message-State: AC+VfDwuLq6Ml3ngWkBZdCs3BbD7yIcXGyZM0xUzqip1RA/7fckSBEDA
        446Jke+oDIdwJ/1a80J1ReXzU5ckhGuWSdS00CBUZ5X2aQQc5Gcjer0=
X-Google-Smtp-Source: ACHHUZ5FCLC9Lk/XrJ1xyPUdn2S7c534a2OQ+v4gT/cdVz21GlzBGJ4HqV4IE9TDJ9Cn1MYyuiX1kBxO3c2RAiNBU7E=
X-Received: by 2002:a05:622a:506:b0:3f9:f877:1129 with SMTP id
 l6-20020a05622a050600b003f9f8771129mr10495qtx.29.1686597093835; Mon, 12 Jun
 2023 12:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230612143414.186389-1-wangkefeng.wang@huawei.com> <20230612143414.186389-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20230612143414.186389-2-wangkefeng.wang@huawei.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 12 Jun 2023 13:10:57 -0600
Message-ID: <CAOUHufYb0ADyh-b2JtmamJ4gHd_M=nYr765ffWbr1oZ9zRCAAg@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] mm: kill [add|del]_page_to_lru_list()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        jgowans@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jun 12, 2023 at 8:19=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
>
> Now no one call [add|del]_page_to_lru_list(), let's drop unused
> page interfaces.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Yu Zhao <yuzhao@google.com>
