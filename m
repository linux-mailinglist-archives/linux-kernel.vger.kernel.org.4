Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1634C61E295
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKFOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiKFOfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:35:43 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A1BDEA8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 06:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667745325; bh=Q/kWR0ROKF1W2o+qbF4bLCol/5LeEdbMZeXPMdUA0lI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=ESwUuOJiJO5QGhfX5L4NLM7ByD9PJeJ7lAnUldjVotNQkTO8BdonXgkuv+sQolUON
         y7/PMTgEy+6E1QxM4VU15AniGK7/1K0VfYGE9h9Xs3yY/z4uZ2TRmyIXXgaRMWlCbe
         2+aQ5erXWqbcW4FUPvYju5eJwgsXPiPMLk+zWmA0=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun,  6 Nov 2022 15:35:24 +0100 (CET)
X-EA-Auth: YnrYQM0wED9JlR5wUwaNZRRqudN9GbO8Yahy7ySl9Z6jyfgQZJwR/uwJBs0+Is73pl51ajY3Gn33AiH/4peR9hCsFsruYFW+
Date:   Sun, 6 Nov 2022 20:05:06 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: clean up error handling in
 rtw_start_drv_threads()
Message-ID: <Y2fGGsV5ZwxmkTNB@qemulion>
References: <20221106133443.8872-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106133443.8872-1-straube.linux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 02:34:43PM +0100, Michael Straube wrote:
> Convert the error handling in the function rtw_start_drv_threads() to
> the common logic used in the kernel. Another step to get rid of _FAIL
> and _SUCCESS which uses inverted logic.

Hello Michael,
Can you please tell how did you find this opportunity for improvement? Are you
using some tool or is it a manual code review/analysis?

Thank you,
./drv

>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/include/osdep_intf.h |  2 +-
>  drivers/staging/r8188eu/os_dep/os_intfs.c    | 17 +++++++----------
>  2 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
> index 0f7d74a3ff6d..6d66cb57225e 100644
> --- a/drivers/staging/r8188eu/include/osdep_intf.h
> +++ b/drivers/staging/r8188eu/include/osdep_intf.h
> @@ -46,7 +46,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter);
>  void rtw_free_drv_sw(struct adapter *padapter);
>  void rtw_reset_drv_sw(struct adapter *padapter);
>
> -u32 rtw_start_drv_threads(struct adapter *padapter);
> +int rtw_start_drv_threads(struct adapter *padapter);
>  void rtw_stop_drv_threads (struct adapter *padapter);
>  void rtw_cancel_all_timer(struct adapter *padapter);
>
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 970f380bac96..66556e07ed93 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -363,18 +363,16 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
>  	return pnetdev;
>  }
>
> -u32 rtw_start_drv_threads(struct adapter *padapter)
> +int rtw_start_drv_threads(struct adapter *padapter)
>  {
> -	u32 _status = _SUCCESS;
> -
>  	padapter->cmdThread = kthread_run(rtw_cmd_thread, padapter, "RTW_CMD_THREAD");
>  	if (IS_ERR(padapter->cmdThread))
> -		_status = _FAIL;
> -	else
> -		/* wait for rtw_cmd_thread() to start running */
> -		wait_for_completion(&padapter->cmdpriv.start_cmd_thread);
> +		return PTR_ERR(padapter->cmdThread);
>
> -	return _status;
> +	/* wait for rtw_cmd_thread() to start running */
> +	wait_for_completion(&padapter->cmdpriv.start_cmd_thread);
> +
> +	return 0;
>  }
>
>  void rtw_stop_drv_threads(struct adapter *padapter)
> @@ -627,8 +625,7 @@ static int _netdev_open(struct net_device *pnetdev)
>
>  		netdev_dbg(pnetdev, "MAC Address = %pM\n", pnetdev->dev_addr);
>
> -		status = rtw_start_drv_threads(padapter);
> -		if (status == _FAIL) {
> +		if (rtw_start_drv_threads(padapter)) {
>  			pr_info("Initialize driver software resource Failed!\n");
>  			goto netdev_open_error;
>  		}
> --
> 2.38.0
>
>


