Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941B55EDF55
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiI1O4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiI1O4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:56:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AE46895E4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:56:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 662F4153B;
        Wed, 28 Sep 2022 07:56:28 -0700 (PDT)
Received: from [10.57.0.129] (unknown [10.57.0.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA6593F73D;
        Wed, 28 Sep 2022 07:56:19 -0700 (PDT)
Message-ID: <b8ad73ea-a20e-0e74-766e-eeb4cdeb1890@arm.com>
Date:   Wed, 28 Sep 2022 15:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] coresight: use sysfs_emit() to instead of
 scnprintf()
Content-Language: en-US
To:     zhangsongyi.cgel@gmail.com
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20220927115136.259926-1-zhang.songyi@zte.com.cn>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220927115136.259926-1-zhang.songyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/09/2022 12:51, zhangsongyi.cgel@gmail.com wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the value
> to be returned to user space.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: James Clark <james.clark@arm.com>

> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 463f449cfb79..3a1b07217932 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -466,7 +466,7 @@ static ssize_t hwevent_enable_show(struct device *dev,
>  	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>  	unsigned long val = drvdata->stmheer;
>  
> -	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
> +	return sysfs_emit(buf, "%#lx\n", val);
>  }
>  
>  static ssize_t hwevent_enable_store(struct device *dev,
> @@ -495,7 +495,7 @@ static ssize_t hwevent_select_show(struct device *dev,
>  	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>  	unsigned long val = drvdata->stmhebsr;
>  
> -	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
> +	return sysfs_emit(buf, "%#lx\n", val);
>  }
>  
>  static ssize_t hwevent_select_store(struct device *dev,
> @@ -530,7 +530,7 @@ static ssize_t port_select_show(struct device *dev,
>  		spin_unlock(&drvdata->spinlock);
>  	}
>  
> -	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
> +	return sysfs_emit(buf, "%#lx\n", val);
>  }
>  
>  static ssize_t port_select_store(struct device *dev,
> @@ -577,7 +577,7 @@ static ssize_t port_enable_show(struct device *dev,
>  		spin_unlock(&drvdata->spinlock);
>  	}
>  
> -	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
> +	return sysfs_emit(buf, "%#lx\n", val);
>  }
>  
>  static ssize_t port_enable_store(struct device *dev,
