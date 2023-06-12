Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF572CBED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjFLQ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjFLQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:58:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EE619C;
        Mon, 12 Jun 2023 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686589084; x=1718125084;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YIGvFiBNE3NCF0ZwQgckoo2K32v08RKeLs7L8rmrvD8=;
  b=B/W6QBYHDPClYr9GbZ5FcOUe6RsDrtqBtUHmaly4GQB3mV51jIf1+0jE
   pJnghZkXeRF5Ul5rze0yi3fkijAdelXsqyyN1k4DUTNaffbBB6k0MosWK
   wzBurWDdiCAaVoY81oLxuZDQptqNf9G/ClnAtVh2Q5Z5wTvjC6i9+3xzD
   2s/oSdjhM504ydqllun3b+G2guoBTt3N9ZVjWAR913GSm4DMeqnLBmkux
   lzUEq6oCnwBJrOUMJ0mNdZsuWKkJTgHhRMa+qPeWpn6x+zuLmKLSlqi04
   TUwKFoPYEt9DkkfhPOl+gHTqlPQCszUUPk4qKG80GSoYcTt+nBY50QLO0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338464657"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="338464657"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 09:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="705467168"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="705467168"
Received: from atulpuri-mobl1.amr.corp.intel.com (HELO [10.212.234.150]) ([10.212.234.150])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 09:58:02 -0700
Message-ID: <f0783f2a-03fd-f893-9470-ed9d7805e2f9@linux.intel.com>
Date:   Mon, 12 Jun 2023 11:58:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: Improve unlocking of a mutex in
 sof_ipc4_widget_free()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jyri Sarha <jyri.sarha@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
        Dan Carpenter <error27@gmail.com>
References: <20230322181830.574635-1-jyri.sarha@linux.intel.com>
 <3a7476b6-2ae9-494e-1840-0915ddf47c2f@web.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <3a7476b6-2ae9-494e-1840-0915ddf47c2f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/23 06:36, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Jun 2023 12:40:09 +0200
> 
> Add a jump target so that a call of the function “mutex_unlock”
> is stored only once in this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  sound/soc/sof/ipc4-topology.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
> index a4e1a70b607d..f0fd1dfa384e 100644
> --- a/sound/soc/sof/ipc4-topology.c
> +++ b/sound/soc/sof/ipc4-topology.c
> @@ -2300,8 +2300,7 @@ static int sof_ipc4_widget_free(struct snd_sof_dev *sdev, struct snd_sof_widget
>  		if (pipeline->use_chain_dma) {
>  			dev_warn(sdev->dev, "use_chain_dma set for scheduler %s",
>  				 swidget->widget->name);
> -			mutex_unlock(&ipc4_data->pipeline_state_mutex);
> -			return 0;
> +			goto unlock;
>  		}
> 
>  		header = SOF_IPC4_GLB_PIPE_INSTANCE_ID(swidget->instance_id);
> @@ -2326,7 +2325,7 @@ static int sof_ipc4_widget_free(struct snd_sof_dev *sdev, struct snd_sof_widget
>  		if (!pipeline->use_chain_dma)
>  			ida_free(&fw_module->m_ida, swidget->instance_id);
>  	}
> -
> +unlock:
>  	mutex_unlock(&ipc4_data->pipeline_state_mutex);
> 
>  	return ret;

The change looks good but I am wondering if we need to print a dev_warn
log which is already done on the sof_ipc4_widget_setup() path.

This seems redundant. Ranjani, can we simplify?
