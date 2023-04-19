Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC96E706F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 02:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjDSAby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 20:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDSAbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 20:31:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF144EC8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 17:31:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v10so9683794wmn.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 17:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1681864310; x=1684456310;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUdvoQeeISKj+zvbRD3zosjSOApgrXF0+iAHmluahYk=;
        b=PxGAQpP7p0zivI9glT8BW7kng9hQ+qUKnmmnrupZ05cztFs1NjA7QcPHYmwxkL+fdm
         3utm4ZoxKZ8mljOeQ3MgCku/Hz+WRYm4FXy+Zdixa3vqMtLEivRZreSEMuRdovq69x2H
         TMN305QliDR2RM7nbjBP/2fkJ1cPP+WuD1ja8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681864310; x=1684456310;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUdvoQeeISKj+zvbRD3zosjSOApgrXF0+iAHmluahYk=;
        b=AdLWel4OYSucjs021/BUl7vezd7D7ZWBxEfNsiZZhG/Z8g9IOQysHioYOs6514Cz0S
         0alZ99GDrOnMQ47bnqR2FJrnQopeUKrWoo0slWo3eIqmY3u1GMOrKfHWAaoNoKvTiDGB
         d9ZBWqqNb7Yr3YplR82yRTtqgRBW7mZ4zQV+5k67CWIke62V8NTURWS2dWD7QI3jeYcB
         I8mp/sP/usfBgU0rb2JDCIre+hI38uw5dztEt+4t3RKw8sASr/2Z1p26Cevksv8bjMFo
         fBuNNRqOGd8yv8GWeOJ3LWLGee+W9MF9LXwkT9ub41BjSXT5aNKmdbobNYLPqkXOUbCY
         GYGQ==
X-Gm-Message-State: AAQBX9emw++WsaDVBjd0lTBmkoIImQmlVQ+di9jS64f8LOzhv7zfsdp1
        Q7ddeoAp0We6zYzGXVTTHUg4QwizM4uEjbtA5Ks=
X-Google-Smtp-Source: AKy350ahtT5WAgzTrewo5BlLP0/S8w3mOMUx+PoWj8YPBYOTMR5zpJrJuK0EYt6qMewJ6u0EKUvSTw==
X-Received: by 2002:a1c:6a08:0:b0:3eb:39e2:915b with SMTP id f8-20020a1c6a08000000b003eb39e2915bmr13709566wmc.31.1681864310390;
        Tue, 18 Apr 2023 17:31:50 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c000900b003f0aa490336sm426787wmc.26.2023.04.18.17.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 17:31:49 -0700 (PDT)
Date:   Wed, 19 Apr 2023 01:31:48 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] printk: console: Create console= parser that
 supports named options
Message-ID: <ZD82dN2us-2IZZt-@chrisdown.name>
References: <cover.1658339046.git.chris@chrisdown.name>
 <732ee897b2bd49ada3f7dee396475c5a2195071b.1658339046.git.chris@chrisdown.name>
 <Yw80MmyBl4js09If@alley>
 <ZD1f-1JjpihR1djd@chrisdown.name>
 <ZD6eC9UBxwg-sG5_@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZD6eC9UBxwg-sG5_@alley>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback! Ack to everything and will change for v4.
