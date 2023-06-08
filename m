Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A5A72774B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjFHGeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjFHGeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:34:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74E26B3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:34:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25669acf1b0so208607a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686206045; x=1688798045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnDSSdACAPeHcVg5eItuX+dGNcC+IfJYwfHJBUCvSt8=;
        b=X/3i2uFWMS40I9rQGsF1U6JUah0z761GEy+ZWFwvKzt9bS8vtMgJeg/OOBV4qL5VK8
         Kvqs5ppIlLErUznnnK+EEzpX2eUz9Hfvq1Zouh6B8ScJYlAgqWjX4KwmPkuNYpzzB7mw
         vfo0Z9871bt+ig3rT+8SXkROd2adNvMgHxHT6W/KEJ+Ae9vuLjeJ3C38zLV9tu23uDUG
         /MKxNh3C+S5JnEpRYPjEjkM17ZpCfmFjGySk1h5CiuBJC0hgGysjtxQ2We/vjTqJ+Wxy
         YJ0js2EnSvh09Q8ZwYLBxqy/vFQyuqVUn4khH60uNxUZSHZt1T+y4wd+RXecmNe7BanN
         cSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686206045; x=1688798045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnDSSdACAPeHcVg5eItuX+dGNcC+IfJYwfHJBUCvSt8=;
        b=YerhZVx+BAFjT3DyMcr7S/TyCoHBkNVjgdkE+CgXZZzDzHLAfxoWBe+SGQ8CLRivgB
         CR42AVhES3aTvIRd7dLw8v+48D+FfUodZEbPkWOA3k801D8XQmJ/X1x3fatzgvBfn/HK
         5tpkfRoJTwvlpkMyOvHIDXcgJ03mtZQVRRPGP4CTbSmcdkUJEs8vbrt4H39sTbAGh3V7
         07aFHMnUuIqKlYNtQYM+SAlZhW0Wu5CeEtTHrh9ffEgz+2DKM5wcDqYZermdyZlItIrQ
         AdbkoNK1HxEcOcs+5iBIhWmyqsr04p6L+GY62rwvVzep0SLnHcO0zx0s6Zq7U7cqqcaX
         M+Tg==
X-Gm-Message-State: AC+VfDwSy1aaqE/60MI+yQinhi6M8uR7+AkPcGNt8qcD9SdTqfFQd8jl
        hKzHRhv+s91sEIZ+f7EBxwLzAZRIsVI6AEEWAaC68RRo27Q=
X-Google-Smtp-Source: ACHHUZ5KM2mQY8wxTlqQixP+J13KMX/s5tR0IsAdq7orD/aCXjVj8X0I+e5e4rE+O2uTJAuErHD+BtISR1zcOgFIDbM=
X-Received: by 2002:a17:90a:8417:b0:256:c632:9848 with SMTP id
 j23-20020a17090a841700b00256c6329848mr6787437pjn.29.1686206044764; Wed, 07
 Jun 2023 23:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230606093135.GA9077@didi-ThinkCentre-M930t-N000>
In-Reply-To: <20230606093135.GA9077@didi-ThinkCentre-M930t-N000>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 8 Jun 2023 14:33:53 +0800
Message-ID: <CAJhGHyA_Z67mF9R6zAGorC13p1r1TeT1525Vgs1CUonv21+G2Q@mail.gmail.com>
Subject: Re: [PATCH] workqueue: introduce queue_work_cpumask to queue work
 onto a given cpumask
To:     tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        zyhtheonly@gmail.com, zyhtheonly@yeah.net, zwp10758@gmail.com
Cc:     tiozhang@didiglobal.com
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

On Tue, Jun 6, 2023 at 5:31=E2=80=AFPM Tio Zhang <tiozhang@didiglobal.com> =
wrote:
>
> Introduce queue_work_cpumask to queue work on a "random" CPU onto a given
> cpumask. It would be helpful when devices/modules want to assign works on
> different cpusets but do not want to maintain extra workqueues, since the=
y
> have to alloc different workqueues and set different
> workqueue_attrs->cpumask in the past times.
>
> For now only available for unbound workqueues, We will try to further
> patch it.
> And default to the first CPU that is in the intersection of the cpumask
> given and the online cpumask.
> The only exception is if the CPU is local in the cpuset we will just use
> the current CPU.
>
> The implementation and comments are referenced from
> 'commit 8204e0c1113d ("workqueue: Provide queue_work_node to queue work
> near a given NUMA node")'
>

The code seems duplicated too. Could you do a little refactoring and make
they (queue_work_cpumask() & queue_work_node()) share some code?
