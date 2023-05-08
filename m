Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987E86FB6BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjEHTal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHTaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:30:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B0359C1;
        Mon,  8 May 2023 12:30:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ac733b813fso54427661fa.1;
        Mon, 08 May 2023 12:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683574236; x=1686166236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpFHmWTSO87snqsRDFQuOr7PS8NeITU+H8E5Qf2YRbk=;
        b=cgbFpOKrBrd11Zhos3+dwntw02ytm8nVOxOtp7uTUYjNx4Xo/v1oCkyhm6+ZH7WZsv
         QexMgoCxRQzU9IAva7BevB2aTXWFfdwJiJ2WpXlaYGGwm/o2TnGVJ9Nx3p9LgU21MhQS
         L8T6LhIuHSiuheq6RSLsl5h4Q0RILfpuN73uqqAwZZOjFOoRlZVXftLMbyizqRi4Tcat
         BVNu029oKHcOZHjCRwoALv5bsy7Zi8OcdgnydSsi9PuVS872zrIZkX/HLFwMD370+6jB
         1bbIv7PeuDfwqVGOL0bZ7slX9lEatiITtWowphuQ99oUzeDmLY41RJMosrH+Ksh3qKVD
         xUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683574236; x=1686166236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpFHmWTSO87snqsRDFQuOr7PS8NeITU+H8E5Qf2YRbk=;
        b=JIAMn1WqHbQUiKDi8YbT7IDncNgtu0RXIBUuqoYfHThsJV2vC4LYb3G1VOcLp+VFgL
         NjKLJDP8WbRqC60NJWBl5ZPHT0fKMqXAvU9C44Y3MINAaAVSK9BUyTDYgK90ME9iTB03
         GfAxUVZJT8kOpbGBTAxo+zMVGc+baio8hADDqOzsW5ep679TaoOZv2rTDB50/+WCnJEo
         bE9B6QM2r+e42kSPScmd8zJ0uSl3mMzvobz5J9Puw9BlkrLIGr7MG8mCMzW2JlDcKV0P
         mF23mXftwbyN2C1EGum00Y3C5m7BLQuwRHc+4zwtn67byZ9/rMdyZeqfbeHOpJkrVYi8
         RfgQ==
X-Gm-Message-State: AC+VfDxv7RrjruGW6qcD9MTLyhKYJg5EtQdPKKxedF1K7KQcHDNnb3in
        aWE2MU/LYNVykvMLAAuNb8bbT33h90iojCfXzGvoy1dz
X-Google-Smtp-Source: ACHHUZ6w+XyOOEFGVf3IYSwWT5GrQg+yjLSZEGJIkk/BVXQnHiqrtCi5Y12Sqn/WmjtzbcofbQ7Ez+81k53R/fcRBr0=
X-Received: by 2002:a2e:a16f:0:b0:2a8:ea22:28ab with SMTP id
 u15-20020a2ea16f000000b002a8ea2228abmr57794ljl.25.1683574235396; Mon, 08 May
 2023 12:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <1683001400-29905-1-git-send-email-quic_saluvala@quicinc.com>
In-Reply-To: <1683001400-29905-1-git-send-email-quic_saluvala@quicinc.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 May 2023 12:30:23 -0700
Message-ID: <CABBYNZ+QLkWhiWfZt0tb50zagsKA8VjtNZ7jefd8iOeMyfCRBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_qca: Add qcomm devcoredump support
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, quic_bgodavar@quicinc.com,
        jiangzp@google.com, mmandlik@google.com
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

Hi Sai,

On Mon, May 1, 2023 at 9:23=E2=80=AFPM Sai Teja Aluvala
<quic_saluvala@quicinc.com> wrote:
>
> Intercept debug exception events from QCA controller and put them into
> a devcoredump using hci devcoredump APIs of hci_core
>
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> Reviewed-by: Manish Mandlik <mmandlik@google.com>
>
> V2:
> --
> Updated to work with the updated HCI devcoredump API.
>
> V1:
> --
> Initial Patch
> ---
>  drivers/bluetooth/hci_qca.c | 190 ++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 138 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index ca98f6d..c94a414 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -77,6 +77,7 @@ enum qca_flags {
>         QCA_MEMDUMP_COLLECTION,
>         QCA_HW_ERROR_EVENT,
>         QCA_SSR_TRIGGERED,
> +       QCA_COREDUMP_TRIGGERED,
>         QCA_BT_OFF,
>         QCA_ROM_FW
>  };
> @@ -116,9 +117,7 @@ enum qca_memdump_states {
>         QCA_MEMDUMP_TIMEOUT,
>  };
>
> -struct qca_memdump_data {
> -       char *memdump_buf_head;
> -       char *memdump_buf_tail;
> +struct qca_memdump_info {
>         u32 current_seq_no;
>         u32 received_dump;
>         u32 ram_dump_size;
> @@ -159,13 +158,15 @@ struct qca_data {
>         struct work_struct ws_tx_vote_off;
>         struct work_struct ctrl_memdump_evt;
>         struct delayed_work ctrl_memdump_timeout;
> -       struct qca_memdump_data *qca_memdump;
> +       struct qca_memdump_info *qca_memdump;
>         unsigned long flags;
>         struct completion drop_ev_comp;
>         wait_queue_head_t suspend_wait_q;
>         enum qca_memdump_states memdump_state;
>         struct mutex hci_memdump_lock;
>
> +       u16 fw_version;
> +       u16 controller_id;
>         /* For debugging purpose */
>         u64 ibs_sent_wacks;
>         u64 ibs_sent_slps;
> @@ -232,6 +233,7 @@ static void qca_regulator_disable(struct qca_serdev *=
qcadev);
>  static void qca_power_shutdown(struct hci_uart *hu);
>  static int qca_power_off(struct hci_dev *hdev);
>  static void qca_controller_memdump(struct work_struct *work);
> +static void qca_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb);
>
>  static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
>  {
> @@ -543,7 +545,8 @@ static void qca_controller_memdump_timeout(struct wor=
k_struct *work)
>         mutex_lock(&qca->hci_memdump_lock);
>         if (test_bit(QCA_MEMDUMP_COLLECTION, &qca->flags)) {
>                 qca->memdump_state =3D QCA_MEMDUMP_TIMEOUT;
> -               if (!test_bit(QCA_HW_ERROR_EVENT, &qca->flags)) {
> +               if ((!test_bit(QCA_HW_ERROR_EVENT, &qca->flags)) ||
> +                       (!test_bit(QCA_COREDUMP_TRIGGERED, &qca->flags)))=
 {
>                         /* Inject hw error event to reset the device
>                          * and driver.
>                          */
> @@ -976,6 +979,28 @@ static int qca_recv_acl_data(struct hci_dev *hdev, s=
truct sk_buff *skb)
>         return hci_recv_frame(hdev, skb);
>  }
>
> +static void qca_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       struct hci_uart *hu =3D hci_get_drvdata(hdev);
> +       struct qca_data *qca =3D hu->priv;
> +       char buf[80];
> +
> +       snprintf(buf, sizeof(buf), "Controller Name: 0x%x\n",
> +               qca->controller_id);
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Firmware Version: 0x%x\n",
> +               qca->fw_version);
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Vendor:Qualcomm\n");
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Driver: %s\n",
> +               hu->serdev->dev.driver->name);
> +       skb_put_data(skb, buf, strlen(buf));
> +}
> +
>  static void qca_controller_memdump(struct work_struct *work)
>  {
>         struct qca_data *qca =3D container_of(work, struct qca_data,
> @@ -983,13 +1008,11 @@ static void qca_controller_memdump(struct work_str=
uct *work)
>         struct hci_uart *hu =3D qca->hu;
>         struct sk_buff *skb;
>         struct qca_memdump_event_hdr *cmd_hdr;
> -       struct qca_memdump_data *qca_memdump =3D qca->qca_memdump;
> +       struct qca_memdump_info *qca_memdump =3D qca->qca_memdump;
>         struct qca_dump_size *dump;
> -       char *memdump_buf;
> -       char nullBuff[QCA_DUMP_PACKET_SIZE] =3D { 0 };
>         u16 seq_no;
> -       u32 dump_size;
>         u32 rx_size;
> +       int ret =3D 0;
>         enum qca_btsoc_type soc_type =3D qca_soc_type(hu);
>
>         while ((skb =3D skb_dequeue(&qca->rx_memdump_q))) {
> @@ -1005,7 +1028,7 @@ static void qca_controller_memdump(struct work_stru=
ct *work)
>                 }
>
>                 if (!qca_memdump) {
> -                       qca_memdump =3D kzalloc(sizeof(struct qca_memdump=
_data),
> +                       qca_memdump =3D kzalloc(sizeof(struct qca_memdump=
_info),
>                                               GFP_ATOMIC);
>                         if (!qca_memdump) {
>                                 mutex_unlock(&qca->hci_memdump_lock);
> @@ -1031,44 +1054,49 @@ static void qca_controller_memdump(struct work_st=
ruct *work)
>                         set_bit(QCA_IBS_DISABLED, &qca->flags);
>                         set_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>                         dump =3D (void *) skb->data;
> -                       dump_size =3D __le32_to_cpu(dump->dump_size);
> -                       if (!(dump_size)) {
> +                       qca_memdump->ram_dump_size =3D __le32_to_cpu(dump=
->dump_size);
> +                       if (!(qca_memdump->ram_dump_size)) {
>                                 bt_dev_err(hu->hdev, "Rx invalid memdump =
size");
>                                 kfree(qca_memdump);
>                                 kfree_skb(skb);
> -                               qca->qca_memdump =3D NULL;
>                                 mutex_unlock(&qca->hci_memdump_lock);
>                                 return;
>                         }
>
> -                       bt_dev_info(hu->hdev, "QCA collecting dump of siz=
e:%u",
> -                                   dump_size);
>                         queue_delayed_work(qca->workqueue,
>                                            &qca->ctrl_memdump_timeout,
> -                                          msecs_to_jiffies(MEMDUMP_TIMEO=
UT_MS)
> -                                         );
> -
> -                       skb_pull(skb, sizeof(dump_size));
> -                       memdump_buf =3D vmalloc(dump_size);
> -                       qca_memdump->ram_dump_size =3D dump_size;
> -                       qca_memdump->memdump_buf_head =3D memdump_buf;
> -                       qca_memdump->memdump_buf_tail =3D memdump_buf;
> -               }
> +                                          msecs_to_jiffies(MEMDUMP_TIMEO=
UT_MS));
> +                       skb_pull(skb, sizeof(qca_memdump->ram_dump_size))=
;
> +                       qca_memdump->current_seq_no =3D 0;
> +                       qca_memdump->received_dump =3D 0;
> +                       ret =3D hci_devcd_init(hu->hdev, qca_memdump->ram=
_dump_size);
> +                       bt_dev_info(hu->hdev, "hci_devcd_init Return:%d",
> +                                   ret);
> +                       if (ret < 0) {
> +                               kfree(qca->qca_memdump);
> +                               qca->qca_memdump =3D NULL;
> +                               qca->memdump_state =3D QCA_MEMDUMP_COLLEC=
TED;
> +                               cancel_delayed_work(&qca->ctrl_memdump_ti=
meout);
> +                               clear_bit(QCA_MEMDUMP_COLLECTION, &qca->f=
lags);
> +                               mutex_unlock(&qca->hci_memdump_lock);
> +                               return;
> +                       }
>
> -               memdump_buf =3D qca_memdump->memdump_buf_tail;
> +                       bt_dev_info(hu->hdev, "QCA collecting dump of siz=
e:%u",
> +                                   qca_memdump->ram_dump_size);
> +
> +               }
>
>                 /* If sequence no 0 is missed then there is no point in
>                  * accepting the other sequences.
>                  */
> -               if (!memdump_buf) {
> +               if (!test_bit(QCA_MEMDUMP_COLLECTION, &qca->flags)) {
>                         bt_dev_err(hu->hdev, "QCA: Discarding other packe=
ts");
>                         kfree(qca_memdump);
>                         kfree_skb(skb);
> -                       qca->qca_memdump =3D NULL;
>                         mutex_unlock(&qca->hci_memdump_lock);
>                         return;
>                 }
> -
>                 /* There could be chance of missing some packets from
>                  * the controller. In such cases let us store the dummy
>                  * packets in the buffer.
> @@ -1078,8 +1106,8 @@ static void qca_controller_memdump(struct work_stru=
ct *work)
>                  * bits, so skip this checking for missing packet.
>                  */
>                 while ((seq_no > qca_memdump->current_seq_no + 1) &&
> -                      (soc_type !=3D QCA_QCA6390) &&
> -                      seq_no !=3D QCA_LAST_SEQUENCE_NUM) {
> +                       (soc_type !=3D QCA_QCA6390) &&
> +                       seq_no !=3D QCA_LAST_SEQUENCE_NUM) {
>                         bt_dev_err(hu->hdev, "QCA controller missed packe=
t:%d",
>                                    qca_memdump->current_seq_no);
>                         rx_size =3D qca_memdump->received_dump;
> @@ -1090,43 +1118,38 @@ static void qca_controller_memdump(struct work_st=
ruct *work)
>                                            qca_memdump->received_dump);
>                                 break;
>                         }
> -                       memcpy(memdump_buf, nullBuff, QCA_DUMP_PACKET_SIZ=
E);
> -                       memdump_buf =3D memdump_buf + QCA_DUMP_PACKET_SIZ=
E;
> +                       hci_devcd_append_pattern(hu->hdev, 0x00,
> +                               QCA_DUMP_PACKET_SIZE);
>                         qca_memdump->received_dump +=3D QCA_DUMP_PACKET_S=
IZE;
>                         qca_memdump->current_seq_no++;
>                 }
>
> -               rx_size =3D qca_memdump->received_dump + skb->len;
> +               rx_size =3D qca_memdump->received_dump  + skb->len;
>                 if (rx_size <=3D qca_memdump->ram_dump_size) {
>                         if ((seq_no !=3D QCA_LAST_SEQUENCE_NUM) &&
> -                           (seq_no !=3D qca_memdump->current_seq_no))
> +                           (seq_no !=3D qca_memdump->current_seq_no)) {
>                                 bt_dev_err(hu->hdev,
>                                            "QCA memdump unexpected packet=
 %d",
>                                            seq_no);
> +                       }
>                         bt_dev_dbg(hu->hdev,
>                                    "QCA memdump packet %d with length %d"=
,
>                                    seq_no, skb->len);
> -                       memcpy(memdump_buf, (unsigned char *)skb->data,
> -                              skb->len);
> -                       memdump_buf =3D memdump_buf + skb->len;
> -                       qca_memdump->memdump_buf_tail =3D memdump_buf;
> -                       qca_memdump->current_seq_no =3D seq_no + 1;
> -                       qca_memdump->received_dump +=3D skb->len;
> +                       hci_devcd_append(hu->hdev, skb);
> +                       qca_memdump->current_seq_no +=3D 1;
> +                       qca_memdump->received_dump =3D rx_size;
>                 } else {
>                         bt_dev_err(hu->hdev,
> -                                  "QCA memdump received %d, no space for=
 packet %d",
> -                                  qca_memdump->received_dump, seq_no);
> +                                  "QCA memdump received no space for pac=
ket %d",
> +                                   qca_memdump->current_seq_no);
>                 }
> -               qca->qca_memdump =3D qca_memdump;
> -               kfree_skb(skb);
> +
>                 if (seq_no =3D=3D QCA_LAST_SEQUENCE_NUM) {
>                         bt_dev_info(hu->hdev,
> -                                   "QCA memdump Done, received %d, total=
 %d",
> -                                   qca_memdump->received_dump,
> -                                   qca_memdump->ram_dump_size);
> -                       memdump_buf =3D qca_memdump->memdump_buf_head;
> -                       dev_coredumpv(&hu->serdev->dev, memdump_buf,
> -                                     qca_memdump->received_dump, GFP_KER=
NEL);
> +                               "QCA memdump Done, received %d, total %d"=
,
> +                               qca_memdump->received_dump,
> +                               qca_memdump->ram_dump_size);
> +                       hci_devcd_complete(hu->hdev);
>                         cancel_delayed_work(&qca->ctrl_memdump_timeout);
>                         kfree(qca->qca_memdump);
>                         qca->qca_memdump =3D NULL;
> @@ -1537,8 +1560,8 @@ static void qca_hw_error(struct hci_dev *hdev, u8 c=
ode)
>         mutex_lock(&qca->hci_memdump_lock);
>         if (qca->memdump_state !=3D QCA_MEMDUMP_COLLECTED) {
>                 bt_dev_err(hu->hdev, "clearing allocated memory due to me=
mdump timeout");
> +               hci_devcd_abort(hu->hdev);
>                 if (qca->qca_memdump) {
> -                       vfree(qca->qca_memdump->memdump_buf_head);
>                         kfree(qca->qca_memdump);
>                         qca->qca_memdump =3D NULL;
>                 }
> @@ -1577,7 +1600,8 @@ static void qca_cmd_timeout(struct hci_dev *hdev)
>         mutex_lock(&qca->hci_memdump_lock);
>         if (qca->memdump_state !=3D QCA_MEMDUMP_COLLECTED) {
>                 qca->memdump_state =3D QCA_MEMDUMP_TIMEOUT;
> -               if (!test_bit(QCA_HW_ERROR_EVENT, &qca->flags)) {
> +               if ((!test_bit(QCA_HW_ERROR_EVENT, &qca->flags)) ||
> +                       (!test_bit(QCA_COREDUMP_TRIGGERED, &qca->flags)))=
 {
>                         /* Inject hw error event to reset the device
>                          * and driver.
>                          */
> @@ -1702,6 +1726,65 @@ static int qca_power_on(struct hci_dev *hdev)
>         return ret;
>  }
>
> +static void hci_coredump_qca(struct hci_dev *hdev)
> +{
> +       struct hci_uart *hu =3D hci_get_drvdata(hdev);
> +       struct qca_data *qca =3D hu->priv;
> +       struct sk_buff *skb;
> +
> +
> +       set_bit(QCA_COREDUMP_TRIGGERED, &qca->flags);
> +       bt_dev_info(hdev, "Enter mem_dump_status: %d", qca->memdump_state=
);
> +
> +       if (qca->memdump_state =3D=3D QCA_MEMDUMP_IDLE) {
> +               /* we need to crash the SOC
> +                * and wait here for 8 seconds to get the dump packets.
> +                * This will block main thread to be on hold until we
> +                * collect dump.
> +                */
> +               set_bit(QCA_SSR_TRIGGERED, &qca->flags);
> +               set_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
> +
> +               skb =3D bt_skb_alloc(QCA_CRASHBYTE_PACKET_LEN, GFP_KERNEL=
);
> +               if (!skb) {
> +                       bt_dev_err(hu->hdev, "Failed to allocate memory f=
or skb packet");
> +                       return;
> +               }
> +
> +               /* We forcefully crash the controller, by sending 0xfb by=
te for
> +                * 1024 times. We also might have chance of losing data, =
To be
> +                * on safer side we send 1096 bytes to the SoC.
> +                */
> +               memset(skb_put(skb, QCA_CRASHBYTE_PACKET_LEN), QCA_MEMDUM=
P_BYTE,
> +                       QCA_CRASHBYTE_PACKET_LEN);
> +               hci_skb_pkt_type(skb) =3D HCI_COMMAND_PKT;
> +               bt_dev_info(hu->hdev, "crash the soc to collect controlle=
r dump");

This seem awkward, the purpose of devcd is to collect coredumps not to
force the controller to crash to then collect it, so if the controller
hasn't crashed it shall not call into devcd, if you doing this as part
of handling a hardware error Id recommend doing it as part of hw_error
callback, that said be aware that you are probably exposing a
vulnerability to your firmware with the code above.

> +
> +               switch (qca->tx_ibs_state) {
> +               case HCI_IBS_TX_WAKING:
> +                       /* Transient state; just keep packet for later */
> +                       skb_queue_tail(&qca->tx_wait_q, skb);
> +                       break;
> +               case HCI_IBS_TX_AWAKE:
> +                       skb_queue_tail(&qca->txq, skb);
> +                       hci_uart_tx_wakeup(hu);
> +                       break;
> +               case HCI_IBS_TX_ASLEEP:
> +                       skb_queue_tail(&qca->tx_wait_q, skb);
> +                       qca->tx_ibs_state =3D HCI_IBS_TX_WAKING;
> +                       /* Schedule a work queue to wake up device */
> +                       queue_work(qca->workqueue, &qca->ws_awake_device)=
;
> +                       break;
> +               }
> +       } else if (qca->memdump_state =3D=3D QCA_MEMDUMP_COLLECTING) {
> +               /* Let us wait here until memory dump collected or
> +                * memory dump timer expired.
> +                */
> +               bt_dev_info(hdev, "waiting for dump to complete");
> +       }
> +       clear_bit(QCA_COREDUMP_TRIGGERED, &qca->flags);
> +}
> +
>  static int qca_setup(struct hci_uart *hu)
>  {
>         struct hci_dev *hdev =3D hu->hdev;
> @@ -1816,6 +1899,9 @@ static int qca_setup(struct hci_uart *hu)
>                 hu->hdev->set_bdaddr =3D qca_set_bdaddr_rome;
>         else
>                 hu->hdev->set_bdaddr =3D qca_set_bdaddr;
> +       qca->fw_version =3D le16_to_cpu(ver.patch_ver);
> +       qca->controller_id =3D le16_to_cpu(ver.rom_ver);
> +       hci_devcd_register(hdev, hci_coredump_qca, qca_dmp_hdr, NULL);
>
>         return ret;
>  }
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
>


--=20
Luiz Augusto von Dentz
