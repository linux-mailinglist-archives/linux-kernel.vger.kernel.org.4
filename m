Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A704726527
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbjFGPzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjFGPzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:55:51 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32EA1FE3;
        Wed,  7 Jun 2023 08:55:38 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-38ede2e0e69so4761340b6e.2;
        Wed, 07 Jun 2023 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686153338; x=1688745338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO0aJJovSF9bV+DSlg1gHqU0aawQtEHtPHuC3Z3Ckl4=;
        b=AhVqhjUey60mWsf9lUma21vKf23qUGRrfdEixj1tR2ZS+pOWcS8XHHtUHcwrw5Cnb1
         MwdaAG1H3s+mOH7ZUG61xLJ38kkS5PvciGnbqHZ+RVgmhbmbRDjt+sGsB6EsTvuRBLeR
         w+8mFRyyYp8wBYe3Qnn6qzrNGt4I1DzhN3ueomwFvzvf4/zsZTqXVO32FAmsz6Um4Rqv
         7mtiEtQh1sP/gvrFMS3xyPeDP3IabjEPjcIU9wdsyw8QGE+HZhvY0G5kOQSX/f6Oe4nD
         LgOZtUfMpQ2aBvHvnmTGZ+hujPUM4wiG1HgvEtA6gcYI82kQzpk2U1LF73vzpPzE8BQZ
         IZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686153338; x=1688745338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO0aJJovSF9bV+DSlg1gHqU0aawQtEHtPHuC3Z3Ckl4=;
        b=IDZ0PSRALn9kdgpMFrEmmQ+65bhi5FoYZQ0yCrsiAw3UeB60/nKYRPwCgXpzflbM8Y
         Cf0ldrSrNP0PARPOW+BfoA7lw4470203x15pFcar32rjD6clJtkTaarWqtOPHWGU/9Ax
         e3arhgq/yCMHF5H4Y21XoOKcPgPO/gNLYv6bYAKsifPpLUb0O9N53+YMA1lQdOuW6nB/
         3lA3k/XC6EqJx13ysrJWRq8qCGIGIf6rKtl+ZMnfnH67shgzbobGgcROVIP8l12rJCdO
         42M9PTOgogwwsuOjbpVtYqNCxgFHsVPW0ZMQoPGGw3M/KcOU9AXrZN/4VEhNfFf+L3kG
         Bu6g==
X-Gm-Message-State: AC+VfDysflIwC6avI9+Xs80Ea/kJb6f7u86hhHFx8ikvNlSRHk6tb4cP
        LQgMMaQdKe37VgoPYL/0iGHPOIO4NaCh3F4zTSI=
X-Google-Smtp-Source: ACHHUZ6pz5aofLeiOdDelx6VrzDDlzr3Qt5LB9eY9BmZAU5x8a4xa5VHCo/bNeY56xEaC1WaI4YME1hiyU4Q088X60g=
X-Received: by 2002:aca:1908:0:b0:398:30af:53b8 with SMTP id
 l8-20020aca1908000000b0039830af53b8mr2841363oii.6.1686153337871; Wed, 07 Jun
 2023 08:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230606051217.2064-1-iecedge@gmail.com> <6ad5fba3-926a-7a23-b21b-abffd33708be@acm.org>
In-Reply-To: <6ad5fba3-926a-7a23-b21b-abffd33708be@acm.org>
From:   Jianlin Lv <iecedge@gmail.com>
Date:   Wed, 7 Jun 2023 23:55:26 +0800
Message-ID: <CAFA-uR_Zn4MdFKs6U6dqPjuVS60yN4RcYU4jJzjknqy7-RWyEQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: sd: support specify probe type of build-in driver
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, paulmck@kernel.org,
        bp@suse.de, peterz@infradead.org, will@kernel.org,
        rdunlap@infradead.org, kim.phillips@amd.com, rostedt@goodmis.org,
        wyes.karny@amd.com, jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 1:38=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 6/5/23 22:12, Jianlin Lv wrote:
> > In scenarios where SCSI disk name sensitivity is crucial, the probe typ=
e
> > of the build-in sd driver can be set to synchronous. As a result,
> > the scsi disk names are deterministic.
>
> Which are these scenarios?
>
> Additionally, how can synchronous scanning of sd devices make a
> difference if there are multiple host bus adapters that use an interface
> type that is scanned asynchronously?
>
> Bart.

The change was prompted by an issue with SCSI devices probing
non-deterministic. On the issue node, there are two types of SCSI hosts:

1. MegaRAID adapters associated with 24 local disks. The disks are named
sequentially as "sda," "sdb," and so on, up to "sdx."
2. STAT controllers associated with the root disk, named "sdy."

Both the MegaRAID adapters and the SATA controller (PCH) are accessed via
the PCIe bus. In theory, depending on their PCIe bus ID in ascending order,
the devices should be initialized in ascending order as well.

However, the SCSI driver currently probes devices asynchronously to allow
for more parallelism.

__driver_attach
  ->if (driver_allows_async_probing(drv))
      async_schedule_dev(__driver_attach_async_helper, dev);

During the probing of SCSI disks attached to MegaRAID, root disk probing
may occur, resulting in a disk naming inconsistency issue.
For example, if root disk probing happens in the middle,it is named "sdq",
The subsequent SCSI disks that are probed will have their names drift,
starting from "sdr" up to "sdy."

For cloud deployment, the local volume provisioner detects and creates PVs
for each local disk (from sda to sdx) on the host, and it cleans up the
disks when they are released.
This requires the logical names of the disks to be deterministic.

Therefore, I have submitted this patch to allow users to configure the
SCSI disk probe type.
If synchronous probing is configured, the SCSI disk probing order is
deterministic and will follow the ascending order of the PCIe bus ID.

Jianlin
