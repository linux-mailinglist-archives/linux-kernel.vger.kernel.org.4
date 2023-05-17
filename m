Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BCB7075C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjEQXBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjEQXBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:01:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB91170E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:01:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae4baa77b2so10719215ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684364508; x=1686956508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BzCe/htlM5mTAaSOzvP8pEpnyOYq7XwMu4hjpniWzo=;
        b=B/J7qvOTlzVBF6bH+lZ1fSjUgxLBV+R4eZ+jYhz/z7+S5IILF0ehttCPGNSyoMI3ub
         pZZlsX3zL98h9GWstYJknqvKryfgKw//T778pjlMZh+uODdCWwpS9hx/J36oaYLURxlS
         cyqOXevDrp4eByr5L4zRgmx+xnpgp96/7O1Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684364508; x=1686956508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BzCe/htlM5mTAaSOzvP8pEpnyOYq7XwMu4hjpniWzo=;
        b=EcIN9dCbf5OK/z3XboGUgvEFbjlJizs2deAhzMQeaCQ/TeeAYR/3pKkteyJoFZ1J9x
         pcxQr59EFKtL6aEtd2DFRVbh3bn0CoGFoE8mvSDe9PJEGxL7ryvt/oYeNm0lUNZq/Cp9
         LDglQGqawug7TZUQ/bWKdMlLfUkpafudEdlrXwJrjmgXo/rN3/uC6vDiibKFqvDbUI5X
         X7EARsxleLlwB08sPynLgHDSntQHZ3ONsdHYlv6x2cktWSk8/bWKk93ITbG1fMKfmyvH
         nFdo8plbPZh4lbyns5JXNVUvbjKCQ33hhsabOZV2x/yV9xQcSXkxIjeB6aN65kGgSX5t
         5Kow==
X-Gm-Message-State: AC+VfDxXIlKPi+8evA/WE6wKx6oEv5u+TRrClBJl5/sKQasSZQ78+Ygo
        UhTOzYmM/VehVwlZw+7l6lufWQ==
X-Google-Smtp-Source: ACHHUZ54qKIN5A4ugmU6aiQY1NXaOIPnQ8RUOJisfyPF5LS+vhwZWZ17iQt+hucvIjzEZ21J39EIWQ==
X-Received: by 2002:a17:902:e5c8:b0:1ad:fa2e:17fc with SMTP id u8-20020a170902e5c800b001adfa2e17fcmr530850plf.2.1684364508211;
        Wed, 17 May 2023 16:01:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902a41400b0019719f752c5sm9901606plq.59.2023.05.17.16.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 16:01:47 -0700 (PDT)
Date:   Wed, 17 May 2023 16:01:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] scsi: lpfc: Use struct_size() helper
Message-ID: <202305171601.B3FF9D0BB@keescook>
References: <cover.1684358315.git.gustavoars@kernel.org>
 <99e06733f5f35c6cd62e05f530b93107bfd03362.1684358315.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99e06733f5f35c6cd62e05f530b93107bfd03362.1684358315.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 03:23:01PM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions of idiom:
> 
> sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count
> 
> where count is the max number of items the flexible array is supposed to
> contain.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/scsi/lpfc/lpfc_ct.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
> index e880d127d7f5..3b95c56023bf 100644
> --- a/drivers/scsi/lpfc/lpfc_ct.c
> +++ b/drivers/scsi/lpfc/lpfc_ct.c
> @@ -3748,8 +3748,7 @@ lpfc_vmid_cmd(struct lpfc_vport *vport,
>  		rap->obj[0].entity_id_len = vmid->vmid_len;
>  		memcpy(rap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
>  		size = RAPP_IDENT_OFFSET +
> -			sizeof(struct lpfc_vmid_rapp_ident_list) +
> -			sizeof(struct entity_id_object);
> +			struct_size(rap, obj, rap->no_of_objects);

Has rap->no_of_objects always been "1"? (i.e. there was a prior
multiplication here before...

-- 
Kees Cook
