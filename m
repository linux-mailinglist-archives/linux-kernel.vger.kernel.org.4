Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D41680F40
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjA3NpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjA3NpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:45:03 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC64436FE4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:44:59 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id k12so8883699qvj.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugVZtlJMCbul+ClapxlnTF/ez9y96CVsPXS5bV38BZw=;
        b=EiKFryFIGfCmSmvtYHlBOMtKPK2BbUFcv/jf3HYk2xXd4Q77rxF1byFZcJ8TKgGTUn
         Gya8eU2rsGvfDVcX84YRQix3PH4l0wjs92ntHgyxQW6xSPHBKkWUrV/+NbZFZTvJ/WWN
         Td8kte7yJFezx+cdg17At23Y68hrrKY0LPJ56CEYx12gh5pRhzTxUhUDCqQbOC1QIgXN
         Fwgndb30t7vQ/CwHYCw6Z33JK38cgTOOI76yJGGk55SvgUHq6wbS97TlK+JbBXl0YhGw
         aZrC4X36zLFtyoyarfOqLHhjnUAbVYhwT8swpQS4NXwuIEcQXbGgdzeOaQFKLy6dM/uK
         NHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugVZtlJMCbul+ClapxlnTF/ez9y96CVsPXS5bV38BZw=;
        b=33VYiZCoguWEj64CfJchBwGwQr3vUISpxt+XKr7k1U+rxeUq7fvxn4Zx4E0k5CK+mV
         NjbO/9OV85TqVPVQFYchbjFBdWU9oPSimTrqJFPMEoXRlfcSkith/fJwrO4BqaW6DsD8
         by9C3ilMk/Phg5NwTB23PzPGRh6E+K8ap8uDYiTWfyL9gfXLlzKBOPDn8aa5q1saqdb+
         MeRp9v6yhrwEOwEdu1xsULnM/H2UNtG0FTCrGzRu6a0ncABWPexhAhbW7RwOtChPFBgq
         UbM3hRik8rL73CUlRrPmBPhX8bBAXeV/qV5WLKXokD2D+KvW6CUpaF3crXvcoHcQKtsp
         Wvcw==
X-Gm-Message-State: AO0yUKWQSTol+Bn8Ka6RqTp7TKel96gagxUvxDX3VmZTZmE5GHVZmHyp
        Kgbv0UxmuHLFY7CvfWjunYVnPA==
X-Google-Smtp-Source: AK7set9gcZ/WoKw2vDlmeneWLKn01zzwOxlTjosfcIVY0YinesBDnBToObheHTTHr+4m1+l1ZFdVLQ==
X-Received: by 2002:a05:6214:ca2:b0:537:7819:c274 with SMTP id s2-20020a0562140ca200b005377819c274mr12112202qvs.36.1675086298974;
        Mon, 30 Jan 2023 05:44:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id i26-20020a05620a151a00b0071ac0c6df4csm4944495qkk.75.2023.01.30.05.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 05:44:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pMUSv-001GaV-JV;
        Mon, 30 Jan 2023 09:44:57 -0400
Date:   Mon, 30 Jan 2023 09:44:57 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Finn Behrens <me@kloenk.de>, Miguel Ojeda <ojeda@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-mdev: add back CONFIG_VFIO dependency
Message-ID: <Y9fJ2Wg+9uRp5TDc@ziepe.ca>
References: <20230126163719.3585002-1-arnd@kernel.org>
 <20230126103811.56d71351.alex.williamson@redhat.com>
 <20230126174044.GA15999@lst.de>
 <20230126104515.3fcb3abf.alex.williamson@redhat.com>
 <20230130073324.GA590@lst.de>
 <a870060c-9438-4383-97e3-e77d1c361b51@app.fastmail.com>
 <b6333b49-ab8e-4f1b-9da5-454dd7d6d6bc@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6333b49-ab8e-4f1b-9da5-454dd7d6d6bc@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 02:39:36PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 30, 2023, at 14:34, Arnd Bergmann wrote:
> > On Mon, Jan 30, 2023, at 08:33, Christoph Hellwig wrote:
> >> On Thu, Jan 26, 2023 at 10:45:15AM -0700, Alex Williamson wrote:
> >>> The culprit is already in my next branch, we just need a fix that
> >>> includes all the cases.  A respin of Arnd's patch would be preferable
> >>> to keep the fixes in one place.  Thanks,
> >>
> >> Arnd, do you plan to resend the patch, or should I take care of it?
> >
> > I sent the v2 last week, it looks like I forgot to add you to Cc there:
> >
> > https://lore.kernel.org/all/20230126211211.1762319-1-arnd@kernel.org/
> 
> I just tried again and see that neither my own script nor the
> normal scripts/get_maintainer.pl picks up the hch@lst.de address
> from the Signed-off-by line in the "Fixes" commit, though it does
> pick up the addresses from Jason, Tony and Alex. I have no idea
> what is going on there.

Christoph is in .get_maintainer.ignore

Jason
