Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF91C74FAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjGKWcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjGKWcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:32:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A921A3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:32:03 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b88f151d8eso72855ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689114723; x=1691706723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=leT/dmHN5ogjVjMKIS2IvCyaGv4tZ/MjdUNv3TIsuVc=;
        b=VxuPsBfSuE2OMcc29zoAaGLA5c9bUziPP6fynRsOyX0sjBNU+jQ49oL8VDUV5rnmNf
         KSqXMxl0aO/I3FPNSR6lYMxG8M6Fo2OMnzOznPIhoC+ZJcIkNqYRPp8aFl9uD+HZvteE
         iGARbOR1v/DSeOnE+STnfqUwGbXg9H0Nq0cKSnYWgHu2s+Sjy5rD2E8bmK0y6VQ81lk7
         ZFzCKzrFP59/mXZPH8lTKc3/LfSXAVOoXnU1sV/wlrvRAgorxyuAGUWppxT1m5PiSrCt
         J1lHBYi1YIS8EKsXts2vop5NpIePmUxF6RovCkBqz0Z02S8IbczR2aUAK8dyFTZblNju
         6dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689114723; x=1691706723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leT/dmHN5ogjVjMKIS2IvCyaGv4tZ/MjdUNv3TIsuVc=;
        b=S9tmG2+mFAmIhAzCa6uNBael/megmCLYIX37DLYEVFI1by4n/iWuHSld7X7txDSx97
         gz/+N0UXB7cYtP3zaX9FcP7DBc80b91FfDSgYjYgF1iItcrBYyLxA9uXFMPnh1U2qvDi
         ENwniXAVmAsyNVK+EY8/yeAasOCRDheuvmYkMIFnFnmTOEr+HuVtyXM2PG5gMmvtAbcd
         mqpuz2eL/pYzfUm1PPB7PHgXAHf793IIt+EqtFZffr5aDzqbYmSHdeUXs17xdn0Gx4pv
         Xm/2KXNL83iIItT3MDCI6dXo8vbvnBFWKp2/Q/2KIH33CqdHluzVDmWb35GTthjjqgUY
         +Vmg==
X-Gm-Message-State: ABy/qLZ6BUnnbcl5Ny5MuML5LAAzZH+Xr5bi76nRu/Qylv06mFxyuQdZ
        8KxXpKodHM3RsuyT/HapDJQQIw==
X-Google-Smtp-Source: APBJJlHEOIM4pRuXNjatx8qUgzwx3oFRUQNp6z68zKQ81/UC1tpGkJtZYVoZe6IvFeUZpc20mYkuwA==
X-Received: by 2002:a17:903:11d0:b0:1b5:b90:1190 with SMTP id q16-20020a17090311d000b001b50b901190mr94063plh.28.1689114723201;
        Tue, 11 Jul 2023 15:32:03 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:8944:7c0b:5d4e:f65b])
        by smtp.gmail.com with ESMTPSA id ij12-20020a170902ab4c00b001b84cd8814bsm2488045plb.65.2023.07.11.15.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:32:02 -0700 (PDT)
Date:   Tue, 11 Jul 2023 15:31:58 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <jstultz@google.com>, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] regmap-irq: Fix out-of-bounds access when allocating
 config buffers
Message-ID: <ZK3YXpzlxhwMGiuj@google.com>
References: <20230711193059.2480971-1-isaacmanjarres@google.com>
 <8e5fba54-9ec7-45a7-8dd6-6ea63d853907@sirena.org.uk>
 <ZK3TiuPZr0A8iaNN@google.com>
 <fde7ae5c-fbda-4c73-84c0-2f8f9750fce1@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde7ae5c-fbda-4c73-84c0-2f8f9750fce1@sirena.org.uk>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:24:59PM +0100, Mark Brown wrote:
> On Tue, Jul 11, 2023 at 03:11:22PM -0700, Isaac Manjarres wrote:
> > On Tue, Jul 11, 2023 at 08:50:08PM +0100, Mark Brown wrote:
> 
> > > Please think hard before including complete backtraces in upstream
> > > reports, they are very large and contain almost no useful information
> > > relative to their size so often obscure the relevant content in your
> > > message. If part of the backtrace is usefully illustrative (it often is
> > > for search engines if nothing else) then it's usually better to pull out
> > > the relevant sections.
> 
> > Thanks for your feedback. I'll go ahead and send out a new version of
> > the patch with a trimmed down commit message.
> 
> It's OK, I did some local edits myself.

Thanks Mark!

--Isaac
