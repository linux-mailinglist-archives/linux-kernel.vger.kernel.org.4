Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433E86AAB36
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCDQqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 11:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:46:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6E51D91D;
        Sat,  4 Mar 2023 08:46:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BC02B801BE;
        Sat,  4 Mar 2023 16:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2F8C433D2;
        Sat,  4 Mar 2023 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677948365;
        bh=yCxYzWUWSrCfh3vnkLZeeoeOXdUaZgimyLewl4HpFaU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lzKuw7vI1E6/tIW8nw0e/yHx7BtedwMlIQcWS9N/d5tXotoAuks+ot762qBSYRUsa
         z5q1f1QFfY7DF6twWGe4kzKxCI2r818zezw1azTZo+FXrw0FUsN0yFAWoxSla7m3pc
         IzO33P48B6w/iP+YY4NF6JhVvYrY9kFXdjp7SrVDgzVQttXBd/qSD2Sy9snmtSUhwg
         AxpUTgXUo2GdDaELufRm9ZDXH/U5HMbrTHBKGcB/PNAjhqM1ZgBOA7oGPQE54sLWYG
         wieuJ+vloE4GRAY/sexg6dAjDhz6OmHBH2swSAYyDdOFHxM1L2nrLJ3odLJIJba5O6
         di/OxOkaCW6IQ==
Date:   Sat, 4 Mar 2023 16:46:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     lars@metafoo.de, andriy.shevchenko@linux.intel.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: Improve the kernel-doc of iio_trigger_poll
Message-ID: <20230304164601.3888bbd4@jic23-huawei>
In-Reply-To: <bd84fc17e9d22eab998bf48720297f9a77689f45.1677761379.git.mehdi.djait.k@gmail.com>
References: <cover.1677761379.git.mehdi.djait.k@gmail.com>
        <bd84fc17e9d22eab998bf48720297f9a77689f45.1677761379.git.mehdi.djait.k@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Mar 2023 14:04:35 +0100
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Move the kernel-doc of the function to industrialio-trigger.c
> Add a note on the context where the function is expected to be called.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
> v2:
> - Changed the expected context of from interrupt to hard IRQ context
> 
>  drivers/iio/industrialio-trigger.c | 7 +++++++
>  include/linux/iio/trigger.h        | 6 ------
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index a2f3cc2f65ef..bb0a44df8740 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -192,6 +192,13 @@ static void iio_trigger_notify_done_atomic(struct iio_trigger *trig)
>  		schedule_work(&trig->reenable_work);
>  }
>  
> +/**
> + * iio_trigger_poll() - Call the IRQ trigger handler of the consumers
> + * @trig: trigger which occurred
> + *
> + * This function needs to be called from a hard IRQ context.
I tweaked this to drop the line below and to say
This function should only be called from a hard IRQ context.

Fun subtlety of English that reminds me of the sign on the London underground
escalators that said "Guide dogs must be carried" thus apparently limiting
their use to people who could find a guide dog to carry.

Here we don't want to oblige all code to call the function :)

> + *
> + */
>  void iio_trigger_poll(struct iio_trigger *trig)
>  {
>  	int i;
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index f6360d9a492d..42da55dc3aa7 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -151,12 +151,6 @@ void iio_trigger_unregister(struct iio_trigger *trig_info);
>   **/
>  int iio_trigger_set_immutable(struct iio_dev *indio_dev, struct iio_trigger *trig);
>  
> -/**
> - * iio_trigger_poll() - called on a trigger occurring
> - * @trig:	trigger which occurred
> - *
> - * Typically called in relevant hardware interrupt handler.
> - **/
>  void iio_trigger_poll(struct iio_trigger *trig);
>  void iio_trigger_poll_chained(struct iio_trigger *trig);
>  

