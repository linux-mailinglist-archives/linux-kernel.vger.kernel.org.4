Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E4670E40
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjAQX5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAQX5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:57:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F517ED52
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673996931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hLUhE+N6wNGcOFfTldSYxDCBe/hAkHMsdAmNF17Xymc=;
        b=Yy7HXnFwAh9UFP7Gg+3qCCUgjGiICNwlu7K+QS3G6MPgJsfnPOCqSPNzikf1cXjTrSuZve
        nbse5ml0m8Kzldsg9w8lv9Kn1JU5v+PJTnPHYE2R917FUQfL9Yy+bOGJDsrvEbCS8FAPkU
        l5vrAbT0azeYZaBd3sJnu9cM8HoMICg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-kQG1wnK5P2WgtZZ4yBe9lw-1; Tue, 17 Jan 2023 18:08:49 -0500
X-MC-Unique: kQG1wnK5P2WgtZZ4yBe9lw-1
Received: by mail-qt1-f200.google.com with SMTP id hf20-20020a05622a609400b003abcad051d2so14503703qtb.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLUhE+N6wNGcOFfTldSYxDCBe/hAkHMsdAmNF17Xymc=;
        b=xCPXQv9jKTiJwslv4Fps7XAVMwfeJp5eeABdl+DeNkp9NwBbl+/FGztNvVYl3eFQ/R
         kc+mnPK2vkL1mECJzNpAFx5HL4AuJeANkTDkOqWCDWRSOmsDc4D88br4Drm/8uCHL7x0
         WhtZwPW07kgmMZrsDRAzYi63cgZ8cd1bmjPpAC/LxVMfqHNJq5npNq+zTqFSwOZI2jIj
         NT43WvT3p9s1w8VpXGNGeza6lTPnO+4Wz4wMKjLTY+QyWePZoZpt13nFFQY7tUAmhJpV
         FQ+6HHu0oWUDNJadJynyb+49dOZKdQPqemU9/vZfhFJO+2BMWnjxJupI2C56ASnF4TUM
         bONA==
X-Gm-Message-State: AFqh2ko4A1Aar6iF5y+vKFFyEHqRzeofIoobaq8sRdAk3f++7uQj4HzB
        Tu0oH+s6OL13v/+X6M+QiY7Zr7nupTA+jGj7roHujPN/QX7dxRf1O6t3S2NLnO81a/QNl9CIpuM
        pMC31QDGr96kYcF+IR9xU+NE=
X-Received: by 2002:a05:622a:1dc4:b0:3b0:12fc:ff96 with SMTP id bn4-20020a05622a1dc400b003b012fcff96mr5892369qtb.23.1673996928009;
        Tue, 17 Jan 2023 15:08:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs0vPxyl1XT+dxMILItLl3+pLEGdNv9Sv+NcGT7bP7sh98JIs9rjlnuL0rLpT8TgvsCATdexQ==
X-Received: by 2002:a05:622a:1dc4:b0:3b0:12fc:ff96 with SMTP id bn4-20020a05622a1dc400b003b012fcff96mr5892349qtb.23.1673996927779;
        Tue, 17 Jan 2023 15:08:47 -0800 (PST)
Received: from localhost (pool-68-160-145-102.bstnma.fios.verizon.net. [68.160.145.102])
        by smtp.gmail.com with ESMTPSA id p15-20020ac8460f000000b003ae33f9260dsm4659239qtn.49.2023.01.17.15.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 15:08:47 -0800 (PST)
Date:   Tue, 17 Jan 2023 18:08:46 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Song Liu <song@kernel.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH rcu v2 06/20] drivers/md: Remove "select SRCU"
Message-ID: <Y8cqfvrfd3pL9ToJ@redhat.com>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
 <20230113001132.3375334-6-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113001132.3375334-6-paulmck@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12 2023 at  7:11P -0500,
Paul E. McKenney <paulmck@kernel.org> wrote:

> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Song Liu <song@kernel.org>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: <dm-devel@redhat.com>
> Cc: <linux-raid@vger.kernel.org>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Acked-by: Mike Snitzer <snitzer@kernel.org>

