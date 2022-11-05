Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DC961D8C8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 09:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKEIgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 04:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKEIge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 04:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A021817
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 01:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4284E60ACD
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 08:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F454C433D6;
        Sat,  5 Nov 2022 08:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667637384;
        bh=+850kjFp9/O373m9G/UkYuxlhudvMpxu6Y0oTFuWEMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VInH5uzv45/xcOetIrVxQf/PvMLxgebHLQAMGi4f87Vb7tGy0HmYhACfZLSxn05Eh
         CP9vSSnqBX3NXKDZkSG088lJRSc8l5/NIAJsl/r+nTQVxv0+iAOhZqjNJ+j4+Yw9CH
         u9Se7gJtwNWCl9/LKJdFPol88NzFT0LLkvzPBBV4=
Date:   Sat, 5 Nov 2022 09:36:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8723bs: Simplify underutilized 2D array
 to 1D array
Message-ID: <Y2YghalNBdtaAQdr@kroah.com>
References: <cover.1667586648.git.drv@mailo.com>
 <4fb8d9783553d15a58e774d7137519d46e58ee3a.1667586648.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fb8d9783553d15a58e774d7137519d46e58ee3a.1667586648.git.drv@mailo.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 12:04:56AM +0530, Deepak R Varma wrote:
> Member variable "Value" of structure iqk_matrix_regs_setting is
> declared to be a 2D array of [3][IQK_Matrix_REG_NUM] grid. However
> the primary index of this array is only used for index 0, the other
> two elements are never used. Simplify this array to a one dimension
> degree. The resultant code is simpler and is easy to maintain.
> 
> Suggested-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c | 18 +++++++++---------
>  drivers/staging/rtl8723bs/hal/odm.h            |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
> index a52748f7b56e..9317a4462c02 100644
> --- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
> +++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
> @@ -244,8 +244,8 @@ void ODM_TxPwrTrackSetPwr_8723B(
>  			Final_CCK_Swing_Index = 0;
> 
>  		setIqkMatrix_8723B(pDM_Odm, Final_OFDM_Swing_Index, RFPath,
> -			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
> -			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
> +			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0],
> +			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[1]);
> 
>  		setCCKFilterCoefficient(pDM_Odm, Final_CCK_Swing_Index);
> 
> @@ -257,8 +257,8 @@ void ODM_TxPwrTrackSetPwr_8723B(
>  			pDM_Odm->Remnant_OFDMSwingIdx[RFPath] = Final_OFDM_Swing_Index - PwrTrackingLimit_OFDM;
> 
>  			setIqkMatrix_8723B(pDM_Odm, PwrTrackingLimit_OFDM, RFPath,
> -				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
> -				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
> +				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0],
> +				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[1]);
> 
>  			pDM_Odm->Modify_TxAGC_Flag_PathA = true;
>  			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, OFDM);
> @@ -267,16 +267,16 @@ void ODM_TxPwrTrackSetPwr_8723B(
>  			pDM_Odm->Remnant_OFDMSwingIdx[RFPath] = Final_OFDM_Swing_Index;
> 
>  			setIqkMatrix_8723B(pDM_Odm, 0, RFPath,
> -				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
> -				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
> +				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0],
> +				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[1]);
> 
>  			pDM_Odm->Modify_TxAGC_Flag_PathA = true;
>  			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, OFDM);
>  			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, HT_MCS0_MCS7);
>  		} else {
>  			setIqkMatrix_8723B(pDM_Odm, Final_OFDM_Swing_Index, RFPath,
> -				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
> -				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
> +				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0],
> +				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[1]);
> 
>  			if (pDM_Odm->Modify_TxAGC_Flag_PathA) { /* If TxAGC has changed, reset TxAGC again */
>  				pDM_Odm->Remnant_OFDMSwingIdx[RFPath] = 0;
> @@ -1760,7 +1760,7 @@ void PHY_IQCalibrate_8723B(
>  /* by sherry 20120321 */
>  	if (final_candidate < 4) {
>  		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
> -			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][i] = result[final_candidate][i];
> +			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[i] = result[final_candidate][i];
>  		pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[0].bIQKDone = true;
>  	}
> 
> diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
> index fe9782d2d4fd..e16a769850c5 100644
> --- a/drivers/staging/rtl8723bs/hal/odm.h
> +++ b/drivers/staging/rtl8723bs/hal/odm.h
> @@ -481,7 +481,7 @@ enum odm_type_alna_e { /* tag_ODM_TYPE_ALNA_Definition */
> 
>  struct iqk_matrix_regs_setting { /* _IQK_MATRIX_REGS_SETTING */
>  	bool bIQKDone;
> -	s32 Value[3][IQK_Matrix_REG_NUM];
> +	s32 Value[IQK_Matrix_REG_NUM];

This field is used to store values (as your above patch shows), but
where is it actually used?  Are you sure it is needed at all?

thanks,

greg k-h
