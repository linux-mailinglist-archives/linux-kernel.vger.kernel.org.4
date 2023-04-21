Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79BD6EA1C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjDUCqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjDUCqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:46:12 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A5A3585;
        Thu, 20 Apr 2023 19:46:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a69f686345so15417535ad.2;
        Thu, 20 Apr 2023 19:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045171; x=1684637171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4MG1ldebCN8w18KiQjjLtylboO9qHQ1hlD9i7pvobs=;
        b=n++x+IO4IgXrj/OR/hsFO8dPXOTVcdeugXF+u2FizNTy3u6VSi/WX+/cK4D58tmyUd
         aDZxuYFGzop1SBcf8b8mwLNeRTnobBYAeOG/FqATuV/PebmDYLhnOdy+5410lZdf0Wl7
         JMK9K2KF/RnW00nVlrKCY4l1JvNJwIXlfOW3j5nm0v/ZZrjobeVTf2zB2mVY4IPt636l
         +XpGi7HrE98yXYtmfkYhhI1gKME+H+LW5dxaeVB6FWiwxSfjVKH7mqesmTwj53xt4CGe
         mN0XoRbM1CPdfu0vMIy0fW1mz9DN1dClGshGFBPuxAQx/jBGpH9yUFA0NMmoUWcpk/Ae
         Cw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045171; x=1684637171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4MG1ldebCN8w18KiQjjLtylboO9qHQ1hlD9i7pvobs=;
        b=IRnp144h0zw8Q3FUWhvjMqTVcBAiFFRD++wiJbo9T4RA77CrVT+zAKzHC634f/s9eS
         ehwnSE7mtZ1GJEojMt4XvgochRppX37TZLXnN74vHHQf3rrs6hdjuADKPiDwEtAnVHJG
         729/7z3e0F/2DRZVpfyFM+VNNE/qXTaZ8/FGHStDMQxg9U96d6jPhXIzYGd8/6hPQSXF
         P9q/uQN3QqdayL80ol+5sho0lYuMJVYHMApYy92g9HQtpHmZlr/1CEUEjMJwQqXncz8T
         LSH4J3pOtyzfahkY8bcO57yZUHld56GDqBE1k49aROUUqrwBU643t32ORczK6Oy4EypN
         1+xQ==
X-Gm-Message-State: AAQBX9cw6X976ben/fNmFb8n64AObtJL2ZfXeE+Sm+OVNvZBsgs+BtvM
        LtJuq7UpQB/5Jbr+3j5OIoGNAdZGhtcfVMdbmgM=
X-Google-Smtp-Source: AKy350bDjCPznbR8mnqZRmImn2jeRAWK1p/HSL+/aBlAcnv5/22Vlry6Nuov8Fa/Hzq+8EMmQJKbTXeKW+ZJRbcOdkw=
X-Received: by 2002:a17:902:c3c5:b0:1a5:309e:d205 with SMTP id
 j5-20020a170902c3c500b001a5309ed205mr3673496plj.21.1682045171094; Thu, 20 Apr
 2023 19:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230413033422.28003-1-zyytlz.wz@163.com> <6a13265d-634e-d52a-44d9-65d05ab28b1a@oracle.com>
In-Reply-To: <6a13265d-634e-d52a-44d9-65d05ab28b1a@oracle.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 21 Apr 2023 10:45:58 +0800
Message-ID: <CAJedcCzJTq6uFU1fGZ2Qhih4dy6z9DYZOwjrT-P8esMSvL0+cw@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: qedi: Fix use after free bug in qedi_remove due
 to race condition
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, njavali@marvell.com,
        mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=
=8820=E6=97=A5=E5=91=A8=E5=9B=9B 23:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On 4/12/23 10:34 PM, Zheng Wang wrote:
> > In qedi_probe, it calls __qedi_probe, which bound &qedi->recovery_work
> > with qedi_recovery_handler and bound &qedi->board_disable_work
> > with qedi_board_disable_work.
> >
> > When it calls qedi_schedule_recovery_handler, it will finally
> > call schedule_delayed_work to start the work.
> >
> > When we call qedi_remove to remove the driver, there
> > may be a sequence as follows:
> >
> > Fix it by finishing the work before cleanup in qedi_remove.
> >
> > CPU0                  CPU1
> >
> >                      |qedi_recovery_handler
> > qedi_remove          |
> >   __qedi_remove      |
> > iscsi_host_free      |
> > scsi_host_put        |
> > //free shost         |
> >                      |iscsi_host_for_each_session
> >                      |//use qedi->shost
> >
> > Fixes: 4b1068f5d74b ("scsi: qedi: Add MFW error recovery process")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> > v2:
> > - remove unnecessary comment suggested by Mike Christie and cancel the =
work
> > after qedi_ops->stop and qedi_ops->ll2->stop which ensure there is no m=
ore
> > work suggested by Manish Rangankar
>
> Look ok to me now. Thanks.
>
> Reviewed-by: Mike Christie <michael.christie@oracle.com>

Thanks for your review.

Best regards,
Zheng
