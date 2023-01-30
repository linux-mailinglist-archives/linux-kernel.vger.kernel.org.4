Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720BF6803D8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjA3Cc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbjA3Ccz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:32:55 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AAF1D902;
        Sun, 29 Jan 2023 18:32:47 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cl23-20020a17090af69700b0022c745bfdc3so3152820pjb.3;
        Sun, 29 Jan 2023 18:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YvrAD5jlR6qmczD9hFrqQPWTdFnbOvkNXHqYGEoAgOg=;
        b=J8EFKuY8LtUEjeEAGmyPcluZIIMN6HbLijz/fkH51M03wOfQVmqkfJt/F5pwpiS4qE
         qmatVSTtvW2XEyPioIpkFnP371kz4hyi8mEecstMYHjSoYJM/T9J0HeaWw6OqhVXsSR2
         h/4NkVsik61cIceUwwM9HEfWtvrWKRdri2Kkvfn66VlhQztmcYA6gQSQ9S8GLeYrigvt
         OZCQd5wpe4NJ6VjRiMP7SOwxWU8c14hO6HnLQTkwsp+o4jgOeeU2Y1WzlX4Yh/zYWVuu
         vZ5qS6YgiO2dFY9hNPIdIoTMLDyAow6HjpXcvi0EjDmNh21Y/eYmPKSkWUZgMLRLeS2U
         gsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvrAD5jlR6qmczD9hFrqQPWTdFnbOvkNXHqYGEoAgOg=;
        b=qkz4R0YT7JHEbj6gjV8hDpQLFATK7ZWjKHzI4oekWlYLwGIB5MpLv2T4EuZwBbGeDg
         9E8xrovW72pweeV8vl3wVvKYIsFWGt5Wgk2iQmLpU1Dhiy9hEoyXHnMBW7F8NtKtHNi9
         DQE92Rnd0sa9hByu7Xrnx1Ri60kKIVjHIFZxiij3H0QBNCNJ9orz69IemtaEmmWtUvJP
         ztvKmPGx6bZ16/WYFeW9g5wftQ3S+QXjJVOcgkmK70PEwIVbhFihe8mJ0ln75q0MzgRA
         BMyIv7GUCe/nbUUmCA+YLhcgsQ1SiSYxrF3gx1yEHMEpE2Isx99Iy9H262jJAG45YxAZ
         lD3w==
X-Gm-Message-State: AO0yUKWAomXCpBK57XbSc8RVHOFZTr+N2EeSJ+b4ht7svI/BZs9wPqjs
        hF0PAt3ao+nLV2IGLgsoQpXD6ZWapDg=
X-Google-Smtp-Source: AK7set8WUm2R0oMx7X6b6bYNktP3YSk+9UKBMzwCn70QOs03VTGmn6uBwYxyl3QwyKF/q18i5glJ9Q==
X-Received: by 2002:a17:902:e20c:b0:196:7f9c:6c86 with SMTP id u12-20020a170902e20c00b001967f9c6c86mr2275043plb.45.1675045966278;
        Sun, 29 Jan 2023 18:32:46 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6882:174b:bc70:101])
        by smtp.gmail.com with ESMTPSA id io6-20020a17090312c600b00194c1281ca9sm6515194plb.166.2023.01.29.18.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 18:32:45 -0800 (PST)
Date:   Sun, 29 Jan 2023 18:32:42 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Hung-yu Wu <hywu@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH RESEND] Input: atmel_captouch - drop obsolete dependency
 on COMPILE_TEST
Message-ID: <Y9csSoYNZmN3+eSy@google.com>
References: <20230127122816.02b6ea26@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127122816.02b6ea26@endymion.delvare>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Fri, Jan 27, 2023 at 12:28:16PM +0100, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> As a nice side effect, dropping the alternative dependency on
> COMPILE_TEST allows removing preprocessor directives, which will
> speed up the build.

I believe I already have your patch in my "next" branch that is feeding
into linux-next.

Thanks.

-- 
Dmitry
