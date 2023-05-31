Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB98717C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjEaJuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjEaJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05D6E2;
        Wed, 31 May 2023 02:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4469B62837;
        Wed, 31 May 2023 09:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E13FC433EF;
        Wed, 31 May 2023 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685526599;
        bh=5vuxklbladyrpsMX6XXo7g2/x5WLHBaVnR3bJgCUi0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvqVlwFrvRz1LIXmnzMu/5/X9qYyUvqiWZtbBi5lBmQs4qu+1F1zNnJRutRRsoJup
         l3i26105JGu4Ng4xC1AySVnz76KEdds4+Vo5Dr9P0O5ZX4OhmCIAXb6Vwjb6ZMpTdm
         7/S07jRlyxf8PhEtanRjGF3+m2s114O6P1EQuGmwB8or7FDokZ/IA/mcPdUSQMzK/K
         O3roHLdgaS1qvGOL6n7BDnZP7KuMLd4XtJvULFunG06GgcNKadn1kqeYtRkNrruWte
         fkQzyPlfKqFjbVz5jtACNioPblnFYx3+R1P+yXECTobDo66dKNzEYXhLL1ZtHUbHzq
         50qMWo38nNmVQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q4ISx-0001Ie-GQ; Wed, 31 May 2023 11:50:03 +0200
Date:   Wed, 31 May 2023 11:50:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_hemantg@quicinc.com
Subject: Re: [PATCH v7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Message-ID: <ZHcYS1PXhhTmrpYa@hovoldconsulting.com>
References: <20230531034338.23121-1-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531034338.23121-1-quic_tjiang@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 11:43:38AM +0800, Tim Jiang wrote:
> This patch adds support for QCA2066 firmware patch and nvm downloading.
> as the RF performance of qca2066 soc chip from different foundries will
> be difference, so we use different nvm to configure them by according
> to board id.
> 
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>  drivers/bluetooth/btqca.c   | 76 ++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btqca.h   |  4 ++
>  drivers/bluetooth/hci_qca.c |  8 +++-
>  3 files changed, 86 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index e7e58a956d15..960a409e16d6 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -205,6 +205,48 @@ static int qca_send_reset(struct hci_dev *hdev)
>  	return 0;
>  }
>  
> +static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
> +{
> +	u8 cmd;
> +	struct sk_buff *skb;
> +	struct edl_event_hdr *edl;
> +	int err = 0;
> +	int bid_len;
> +
> +	bt_dev_dbg(hdev, "QCA read board ID");

Drop this.

> +
> +	cmd = EDL_GET_BID_REQ_CMD;
> +	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
> +				&cmd, 0, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Reading QCA board ID failed (%d)", err);
> +		return err;
> +	}
> +
> +	edl = skb_pull_data(skb, sizeof(*edl));
> +	if (!edl) {
> +		bt_dev_err(hdev, "QCA read board ID with no header");
> +		err = -EILSEQ;
> +		goto out;
> +	}
> +
> +	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
> +	    edl->rtype != EDL_GET_BID_REQ_CMD) {
> +		bt_dev_err(hdev, "QCA Wrong packet: %d %d", edl->cresp, edl->rtype);
> +		err = -EIO;
> +		goto out;
> +	}
> +
> +	bid_len = edl->data[0];
> +	*bid = (edl->data[1] << 8) + edl->data[2];
> +	bt_dev_info(hdev, "%s: bid len = %x, bid = %x", __func__, bid_len, *bid);

This type of information should not be printed by default.

At most this should be dev_dbg() level, but it should probably just be
dropped.

> +
> +out:
> +	kfree_skb(skb);
> +	return err;
> +}
> +
>  int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>  {
>  	struct sk_buff *skb;
> @@ -574,6 +616,29 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  }
>  EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>  
> +static void qca_generate_nvm_name(struct hci_dev *hdev, char *fwname,
> +		   size_t max_size, struct qca_btsoc_version ver, u16 bid)
> +{
> +	u8 rom_ver = 0;

Drop the redundant initialisation.

> +	u32 soc_ver;
> +	const char *variant;
> +
> +	soc_ver = get_soc_ver(ver.soc_id, ver.rom_ver);
> +	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
> +
> +	if ((le32_to_cpu(ver.soc_id) & 0x0000ff00) == QCA_HSP_GF_SOC_ID)  /* hsp gf chip */
> +		variant = "g";
> +	else
> +		variant = "";
> +
> +	if (bid == 0x0)
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
> +	else
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
> +
> +	bt_dev_info(hdev, "%s: nvm name is %s", __func__, fwname);

dev_dbg(), if at all needed.

> +}
> +
>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
>  		   const char *firmware_name)

> @@ -644,7 +716,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  			snprintf(config.fwname, sizeof(config.fwname),
>  				 "qca/crnv%02x.bin", rom_ver);
>  		}
> -	}
> +	} else if (soc_type == QCA_QCA2066)
> +		qca_generate_nvm_name(hdev, config.fwname, sizeof(config.fwname),
> +				ver, boardid);

Missing brackets (if one branch has them, all of them should even the
current code may not be following this).

>  	else if (soc_type == QCA_QCA6390)
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/htnv%02x.bin", rom_ver);

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 1b064504b388..bf7683040ebd 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1729,7 +1729,7 @@ static int qca_setup(struct hci_uart *hu)
>  	bt_dev_info(hdev, "setting up %s",
>  		qca_is_wcn399x(soc_type) ? "wcn399x" :
>  		(soc_type == QCA_WCN6750) ? "wcn6750" :
> -		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
> +		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390/QCA2066");

This just looks very lazy.

How about cleaning up the current implementation if you don't want to
make this expression worse than it already is?

>  
>  	qca->memdump_state = QCA_MEMDUMP_IDLE;
>  

Johan
