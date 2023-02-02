Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7907B6885AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjBBRnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjBBRnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:43:06 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAADF750;
        Thu,  2 Feb 2023 09:43:03 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A8A857DE;
        Thu,  2 Feb 2023 17:43:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A8A857DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675359782; bh=PxA7ujXI1+GDbneMDrevXJzUPLi+MvBS1xayrOxmm94=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cgg6cHyUcDzv5j52V0ieDCfeBC+xu4R/we712yB8uqxmISclKyUum0fEtCvzRCKvI
         GsFYBiI+M7onCLmhAQ5UQV89/c9p+x5h/rg9DlWqjL9Kur67mShsTuJljUI+Hu+Jrx
         tbiL/eZcpXrrbrGk3YNznId/pXUq/b2M3/TaI7AAAdDBBzAFePvrmyPwdn5njupAbS
         2RK2vDeG7CZB6zTKOuT9sar5xGno7dWe+lmYtBPQ0s3M2obmyn6hwKbAb7GxCq+j4n
         MyqY/LBxzKuHfyfcCMTuCSmPeYDB+n2dk9ujGkI3KxcPBPTJwAVyCfEe6+qb4YKSIz
         /EJqIodhktU7A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, sshefali021@gmail.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: add workload-tracing document to admin-guide
In-Reply-To: <20230131221105.39216-1-skhan@linuxfoundation.org>
References: <20230131221105.39216-1-skhan@linuxfoundation.org>
Date:   Thu, 02 Feb 2023 10:43:01 -0700
Message-ID: <87edr8vu8q.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

> Add a new section to the admin-guide with information of interest to
> application developers and system integrators doing analysis of the
> Linux kernel for safety critical applications.
>
> This section will contain documents supporting analysis of kernel
> interactions with applications, and key kernel subsystems expectations.
>
> Add a new workload-tracing document to this new section.
>
> Signed-off-by: Shefali Sharma <sshefali021@gmail.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v2: Addressed review comments on v2
>
>  Documentation/admin-guide/index.rst           |  11 +
>  .../admin-guide/workload-tracing.rst          | 605 ++++++++++++++++++
>  2 files changed, 616 insertions(+)
>  create mode 100644 Documentation/admin-guide/workload-tracing.rst

I've applied this with a couple of sphinx tweaks, including:

> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 5bfafcbb9562..f475554382e2 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -56,6 +56,17 @@ ABI will be found here.
>  
>     sysfs-rules
>  
> +This is the beginning of a section with information of interest to
> +application developers and system integrators doing analysis of the
> +Linux kernel for safety critical applications. Documents supporting
> +analysis of kernel interactions with applications, and key kernel
> +subsystems expectations will be found here.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   workload-tracing
> +
>  The rest of this manual consists of various unordered guides on how to
>  configure specific aspects of kernel behavior to your liking.
>  
> diff --git a/Documentation/admin-guide/workload-tracing.rst b/Documentation/admin-guide/workload-tracing.rst
> new file mode 100644
> index 000000000000..5fad64b4ebd6
> --- /dev/null
> +++ b/Documentation/admin-guide/workload-tracing.rst
> @@ -0,0 +1,605 @@
> +.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
> +
> +Discovering Linux kernel subsystems used by a workload
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++

This doesn't follow our normal conventions, so I made it:

> ======================================================
> Discovering Linux kernel subsystems used by a workload
> ======================================================

Instead.

Thanks,

jon
