Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45169711E12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjEZCjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjEZCjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75DEE6;
        Thu, 25 May 2023 19:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A84564C6F;
        Fri, 26 May 2023 02:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3D5C433EF;
        Fri, 26 May 2023 02:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685068768;
        bh=EERlqtTQFu4zaiK5VJdJnzeU2mLn2j64zgfoHXd3vdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPOFssIFixk1PVl+LdDPvLRbPZkPCrGW+eLBDlgBLtJ5n8Dcxvivs4B51l4Ds4gVg
         0y6hEcpcpnPTTciBD4cu3QpHzrXlgAudlnDUm2XbJ4XNgGPmuQHPRp5ooQej458LZs
         avk4mGz6eQVtslKb07OyONU2pA1YKeJeJSh9W7Jh1vLNJSBkwtLeYQgtycOe3fpHSs
         vD3TRsqWjB5REg1aXalCknJUzKXp0KT7H+B0VwfHl686neAUlhoSNs4dJPEbp8BZot
         GXxpgSHsSbqS2ntlP/B3GT0Xv1xwZdieNsZULfwfiNq1dnzvFvFXI+VHGomLsPCnQl
         sjf1++Y6F+TWg==
Date:   Thu, 25 May 2023 19:43:17 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, ansuelsmth@gmail.com
Subject: Re: [PATCH v4 5/5] cpufreq: qcom-nvmem: use helper to get SMEM SoC ID
Message-ID: <20230526024317.3t6nfv2aw27mrlj5@ripper>
References: <20230525210214.78235-1-robimarko@gmail.com>
 <20230525210214.78235-5-robimarko@gmail.com>
 <5382b518-7691-ee70-c522-9ce0b14d60c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5382b518-7691-ee70-c522-9ce0b14d60c1@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 01:18:02AM +0200, Konrad Dybcio wrote:
> 
> 
> On 25.05.2023 23:02, Robert Marko wrote:
> > Now that SMEM exports a helper to get the SMEM SoC ID lets utilize it.
> > Currently qcom_cpufreq_get_msm_id() is encoding the returned SMEM SoC ID
> > into an enum, however there is no reason to do so and we can just match
> > directly on the SMEM SoC ID as returned by qcom_smem_get_soc_id().
> > 
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Changes in v4:
> > * Adapt to name change to qcom_smem_get_soc_id()
> > 
> > Changes in v3:
> > * Adapt to helper using argument now
> > 
> > Changes in v2:
> > * Utilize helper exported by SMEM instead of refactoring
> > qcom_cpufreq_get_msm_id()
> > ---
> >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 56 +++++-----------------------
> >  1 file changed, 10 insertions(+), 46 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > index 60e99be2d3db..a88b6fe5db50 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > @@ -29,16 +29,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/soc/qcom/smem.h>
> >  
> > -#define MSM_ID_SMEM	137
> > -
> >  #include <dt-bindings/arm/qcom,ids.h>
> >  
> > -enum _msm8996_version {
> > -	MSM8996_V3,
> > -	MSM8996_SG,
> > -	NUM_OF_MSM8996_VERSIONS,
> > -};
> > -
> >  struct qcom_cpufreq_drv;
> >  
> >  struct qcom_cpufreq_match_data {
> > @@ -135,60 +127,32 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
> >  	dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
> >  }
> >  
> > -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
> > -{
> > -	size_t len;
> > -	u32 *msm_id;
> > -	enum _msm8996_version version;
> > -
> > -	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
> > -	if (IS_ERR(msm_id))
> > -		return NUM_OF_MSM8996_VERSIONS;
> > -
> > -	/* The first 4 bytes are format, next to them is the actual msm-id */
> > -	msm_id++;
> > -
> > -	switch ((enum _msm_id)*msm_id) {
> > -	case QCOM_ID_MSM8996:
> > -	case QCOM_ID_APQ8096:
> > -		version = MSM8996_V3;
> > -		break;
> > -	case QCOM_ID_MSM8996SG:
> > -	case QCOM_ID_APQ8096SG:
> > -		version = MSM8996_SG;
> > -		break;
> > -	default:
> > -		version = NUM_OF_MSM8996_VERSIONS;
> > -	}
> > -
> > -	return version;
> > -}
> > -
> >  static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
> >  					  struct nvmem_cell *speedbin_nvmem,
> >  					  char **pvs_name,
> >  					  struct qcom_cpufreq_drv *drv)
> >  {
> >  	size_t len;
> > +	u32 msm_id;
> __le32
> 
> >  	u8 *speedbin;
> > -	enum _msm8996_version msm8996_version;
> > +	int ret;
> >  	*pvs_name = NULL;
> >  
> > -	msm8996_version = qcom_cpufreq_get_msm_id();
> > -	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> > -		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> > -		return -ENODEV;
> > -	}
> > +	ret = qcom_smem_get_soc_id(&msm_id);
> > +	if (ret)
> > +		return ret;
> Now since it can return a PTR_ERR, you should check for IS_ERR
> and return ERR_PTR if that happens

No, the PTR_ERR() extracted the error value out of the pointer, so it's
just an integer now (or zero on success). So this is looking correct to
me.

> 
> LGTM otherwise!
> 
> Konrad
> >  
> >  	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> >  	if (IS_ERR(speedbin))
> >  		return PTR_ERR(speedbin);
> >  
> > -	switch (msm8996_version) {
> > -	case MSM8996_V3:
> > +	switch (msm_id) {
> > +	case QCOM_ID_MSM8996:

And here are those cpu-endian constants... If msm_id is a __le32 then
all these constants needs to be cpu_to_le32().

Regards,
Bjorn

> > +	case QCOM_ID_APQ8096:
> >  		drv->versions = 1 << (unsigned int)(*speedbin);
> >  		break;
> > -	case MSM8996_SG:
> > +	case QCOM_ID_MSM8996SG:
> > +	case QCOM_ID_APQ8096SG:
> >  		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
> >  		break;
> >  	default:
