Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0C762CC97
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiKPVUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKPVUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB45661BA4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668633567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vCYGmyLDobaOWhMO5cqt6VIfl5tBZ1SXgoRZ3UG9G7A=;
        b=ZU8kwq4S1DDZW7gV3OJwTIIxSyQfNA0a9Sa0ne8DYVnRicTTqkUgv73Ha6FRhzaXSJGAso
        gF9JhSGx/2G6G3z59Qb/uMoj1p3CmgtSOn2tCV1Hg7d2gDDn8Q3+cMQx9KEFyzIBmKu9PI
        bWUOPDczyL+cjVFRZozAxgzfczxVdUw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-HUcaD9CDMTib4OSDJR4lQQ-1; Wed, 16 Nov 2022 16:19:25 -0500
X-MC-Unique: HUcaD9CDMTib4OSDJR4lQQ-1
Received: by mail-qt1-f197.google.com with SMTP id i13-20020ac8764d000000b003a4ec8693dcso14226208qtr.14
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCYGmyLDobaOWhMO5cqt6VIfl5tBZ1SXgoRZ3UG9G7A=;
        b=nHLcpXnNp9McIUm2YsR0uOeGAnE342TmHh3ZwFQf+ccNrWQsngOdlQ71x2RMd0MZI0
         rq78remp6dKN/mpJ9KJT/2M1vGeld3ic70cbFsupAMFHqmiPbol+LuA7L/nMhkOrjnvB
         4Wf4xhXPNjFMGHl/DrI+kxGdesfyEWZZzWSM2N98FGRbOiQsOhvEcqBCsJdXjFHn0ITA
         Z0QL0qKgpNpCfwrP+ytTGXAFyDz++Bp4/ciU3u9WDjGp4VsH7t736jFySzssa/raBTyw
         gjU6g6Bp7agvvWrSKkoVJe62opPxbo0zgG6zznh0FWuCqDBaEhbDU3CX7FgIVrfU9LQ2
         XsRQ==
X-Gm-Message-State: ANoB5pnlpLj3eHkWTrq3HMLuc5jOPmBkjdlBSIhb1Du5h+4ZrOwW9fuL
        2emxE+ZUvOyGfPznxd9U5WJm9lU0jPsWJDMc2HByurw9KPKXj/RjADcYjCL6p/yMhiYrXFzMgW6
        4SkBfOuzsx+Z0q2BOMub5OKM=
X-Received: by 2002:ae9:e00a:0:b0:6fa:dde:394b with SMTP id m10-20020ae9e00a000000b006fa0dde394bmr20880850qkk.265.1668633565301;
        Wed, 16 Nov 2022 13:19:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf79d3ufTC3euri2dfEG/6gEWLrTi+hGugOKpv+coUCcCq4MU9SJtMQwDTIFAPdLoCphODrNwg==
X-Received: by 2002:ae9:e00a:0:b0:6fa:dde:394b with SMTP id m10-20020ae9e00a000000b006fa0dde394bmr20880827qkk.265.1668633565092;
        Wed, 16 Nov 2022 13:19:25 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id bj17-20020a05620a191100b006cfc1d827cbsm10879419qkb.9.2022.11.16.13.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:19:24 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:19:23 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3 03/10] dm: cleanup open_table_device
Message-ID: <Y3VT22zmwOlrxdsw@redhat.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
 <20221115141054.1051801-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115141054.1051801-4-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15 2022 at  9:10P -0500,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Christoph Hellwig <hch@lst.de>
> 
> Move all the logic for allocation the table_device and linking it into
> the list into the open_table_device.  This keeps the code tidy and
> ensures that the table_devices only exist in fully initialized state.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

