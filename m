Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE6674D270
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGJJ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGJJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:58:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D104512A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:56:38 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so5067384f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688982997; x=1691574997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxo6f4leuXFk8pF78YeuZhQwZuNDYfHXt3wH4Pqp5I8=;
        b=GniF6jgEJS2WQWv65E+pLR1FddQDBSIsGiytSe0RL3z06pXU0nhMZtVeEJaalwws3U
         HulmAiRP5r28dU8nGm0JokvgARWfPQNQtguWK/NZhoq/5RQaGhvdgg3JRLbigwal73Dj
         CLUVJtn8E8v8xjCO2Sz2cY39r02qb+xgHJi3N0yvC83AIzaYPXL6batITn7mgaoW2h2O
         FbdVAohVt6QJDp4ROYX1HL1+neATgqMySU5iZm9fsIUrOPberLWBOfwnVwS9e3h/OQv5
         PUTj8vSfXwvYwOD9yMZp6qNhA4FvzvhmGWr44qfNZnO0MzgtkSdAvBzX6JswX+Pacn2s
         XI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982997; x=1691574997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxo6f4leuXFk8pF78YeuZhQwZuNDYfHXt3wH4Pqp5I8=;
        b=etOf/oBSx3A/6qccx5vLiyD2AJZY/N3uajadBhY4dOfHCeJIXNH0Ly4G+V6A8NwoUb
         7cwTmHtmW4swiQzx1OBXJq3QS2I4Kremd00qKJBV5mVstAQN1sitM56i22EjdSoAH1Nn
         9Lj4qp5mkVTIKNZtCtXLzaKMh5Tt/Dsbr1/+Vb5qKYbgqy7yfX/JkIpLQCuEUxE497Q2
         H6NisN38Sq5yTQE6rCon5ct3HNf2OkAtIvajofRu2sScwcOO+f2lTUa4ta0kRD8gVA7s
         nu8lSm+fJfBryY9r7B0Va3YanCvtkhX2d9NvfF2tYU5UgaN7KlMf0e1qz6iGXMpxZsU8
         FnpQ==
X-Gm-Message-State: ABy/qLbe+W1lK8AW0F8UmjB3MT2/woBLZqDwsmz+wB7sv0wJ4tOHeVfn
        gaFDZb9ZVqW4PU8AL6UxBtuzIzZi6qrYfl/ecDI=
X-Google-Smtp-Source: APBJJlE4RKdYwtdNSj2M5c0AJZPi+ooia9Jv6ZuxVWbvTi6oBkrSMovPXcWiGubFT0BFzahcM8f38A==
X-Received: by 2002:adf:ec50:0:b0:315:9993:1caa with SMTP id w16-20020adfec50000000b0031599931caamr4181286wrn.12.1688982997309;
        Mon, 10 Jul 2023 02:56:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y18-20020adfd092000000b0031424950a99sm11257569wrh.81.2023.07.10.02.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:56:35 -0700 (PDT)
Date:   Mon, 10 Jul 2023 12:56:30 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Linke Li <lilinke99@foxmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Linke Li <lilinke99@gmail.com>
Subject: Re: [PATCH] isofs: fix undefined behavior in iso_date()
Message-ID: <79582844-3178-451c-822e-a692bfd27e9c@moroto.mountain>
References: <tencent_4D921A8D1F69E70C85C28875DC829E28EC09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4D921A8D1F69E70C85C28875DC829E28EC09@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like maybe there is an issue with "year" as well.

fs/isofs/util.c
    19  int iso_date(u8 *p, int flag)
    20  {
    21          int year, month, day, hour, minute, second, tz;
    22          int crtime;
    23
    24          year = p[0];
                       ^^^^^
year is 0-255.

    25          month = p[1];
    26          day = p[2];
    27          hour = p[3];
    28          minute = p[4];
    29          second = p[5];
    30          if (flag == 0) tz = p[6]; /* High sierra has no time zone */
    31          else tz = 0;
    32          
    33          if (year < 0) {
                    ^^^^^^^^
But this checks year for < 0 which is impossible.  Should it be:

	year = (signed char)p[0];?

    34                  crtime = 0;
    35          } else {
    36                  crtime = mktime64(year+1900, month, day, hour, minute, second);
    37
    38                  /* sign extend */
    39                  if (tz & 0x80)
    40                          tz |= (-1 << 8);
    41                  
    42                  /*

regards,
dan carpenter

