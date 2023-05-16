Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B41704332
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjEPCC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEPCCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:02:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9A013E;
        Mon, 15 May 2023 19:02:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-305f0491e62so13121717f8f.3;
        Mon, 15 May 2023 19:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684202542; x=1686794542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4g9HEGXPLwrjknS4GYOGaRRLrVJwwRsPWLzFVuHVww=;
        b=geUPPa9RsOZea2T7xZ8hkLNfFtu6foz15oRoD+fJn4TuaET0BOdk+x3CtA+HX1YAUO
         TFXwNoUn3OQgnazxidl/DrUVII2RCtSAgmYsdWoMkb4QEo3PsrtlL38nZuw/PLUqeOcP
         jiudZgJBtcnbThi6WBsZ+e/dX4YkBmlPnyz5N0RQb7fsEzxb8qN5uIKosOn7yahn1byw
         UO1HDS+kbGA1V3LstPvEmMsGSp4i4oB+zNeTESJbTEvr5aAOdHYCFSsubPQBkARxQ36Y
         /WvkOkzELQx+cNKJs1b35ajRBpO5lhUMzIoNXWtAutQBTLUtpj3MLKFmuFEbvksnS8gl
         MkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684202542; x=1686794542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4g9HEGXPLwrjknS4GYOGaRRLrVJwwRsPWLzFVuHVww=;
        b=OXdx6HiV6kAQJR/e4H9XBc8ItYFOuOcYkgbHHuesGjGy5OSNS0xs6cZ8OR32qi9iag
         QM2YWtc/r/Z9NBU9PJn7PiN7knI5JyeHrwnMMLuRrvpA7Vg76YM9eoRRpBx9SpAyeQjc
         4jJUoNRj+JlC9u8Ub4n72aymAVncj6FviLZoJAJCXG0ODdPer0LIiwUB7onwxUEvKgor
         dxaKenKob3ZOVoxYWScaLlarbmL20MQ0VpMmB9nE88/pB4hAmYEDo+bFs2ZH2jlmDTxO
         DpABZN4bYaEDgpVTjKxWa7VI+/4aKvYo13Ft9gu8GPosr6HBV7JAW+bTpFTHJEWROIE+
         HaHA==
X-Gm-Message-State: AC+VfDz6xUUEiJAkn7xQ0maHLNdvE0Vb2ISGRshNxcloWL0dxNdDf4SG
        8+N//8dn9SLgcq2F8f1vQXjRX6dvHi8SKylWejqY3Xs+Lpw1eg==
X-Google-Smtp-Source: ACHHUZ5chZC+O7dPO9pGK8Tf2Vdj9vVGaFKVjUw5DMs1nUXdocYr/zBW+ORTVhYbAxrb0rr9/cAfxoecla/DGsB4KJg=
X-Received: by 2002:adf:e28d:0:b0:307:9da1:c9d8 with SMTP id
 v13-20020adfe28d000000b003079da1c9d8mr18671097wri.4.1684202541510; Mon, 15
 May 2023 19:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230516013345.723623-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230516013345.723623-1-azeemshaikh38@gmail.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Mon, 15 May 2023 22:02:10 -0400
Message-ID: <CADmuW3U_tGb+2E5DZVBjMKGTezsTFh5pTjDhJfQ_mNcMvk5GPQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: bfa: Replace all non-returning strlcpy with strscpy
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc linux-hardening@vger.kernel.org

On Mon, May 15, 2023 at 9:35=E2=80=AFPM Azeem Shaikh <azeemshaikh38@gmail.c=
om> wrote:
>
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/scsi/bfa/bfa_fcbuild.c   |    4 ++--
>  drivers/scsi/bfa/bfa_fcs.c       |    4 ++--
>  drivers/scsi/bfa/bfa_fcs_lport.c |   20 ++++++++++----------
>  drivers/scsi/bfa/bfa_ioc.c       |    2 +-
>  drivers/scsi/bfa/bfa_svc.c       |    2 +-
>  drivers/scsi/bfa/bfad.c          |   10 +++++-----
>  drivers/scsi/bfa/bfad_attr.c     |    2 +-
>  drivers/scsi/bfa/bfad_bsg.c      |    4 ++--
>  drivers/scsi/bfa/bfad_im.c       |    2 +-
>  9 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/scsi/bfa/bfa_fcbuild.c b/drivers/scsi/bfa/bfa_fcbuil=
d.c
> index df18d9d2af53..773c84af784c 100644
> --- a/drivers/scsi/bfa/bfa_fcbuild.c
> +++ b/drivers/scsi/bfa/bfa_fcbuild.c
> @@ -1134,7 +1134,7 @@ fc_rspnid_build(struct fchs_s *fchs, void *pyld, u3=
2 s_id, u16 ox_id,
>         memset(rspnid, 0, sizeof(struct fcgs_rspnid_req_s));
>
>         rspnid->dap =3D s_id;
> -       strlcpy(rspnid->spn, name, sizeof(rspnid->spn));
> +       strscpy(rspnid->spn, name, sizeof(rspnid->spn));
>         rspnid->spn_len =3D (u8) strlen(rspnid->spn);
>
>         return sizeof(struct fcgs_rspnid_req_s) + sizeof(struct ct_hdr_s)=
;
> @@ -1155,7 +1155,7 @@ fc_rsnn_nn_build(struct fchs_s *fchs, void *pyld, u=
32 s_id,
>         memset(rsnn_nn, 0, sizeof(struct fcgs_rsnn_nn_req_s));
>
>         rsnn_nn->node_name =3D node_name;
> -       strlcpy(rsnn_nn->snn, name, sizeof(rsnn_nn->snn));
> +       strscpy(rsnn_nn->snn, name, sizeof(rsnn_nn->snn));
>         rsnn_nn->snn_len =3D (u8) strlen(rsnn_nn->snn);
>
>         return sizeof(struct fcgs_rsnn_nn_req_s) + sizeof(struct ct_hdr_s=
);
> diff --git a/drivers/scsi/bfa/bfa_fcs.c b/drivers/scsi/bfa/bfa_fcs.c
> index d2d396ca0e9a..5023c0ab4277 100644
> --- a/drivers/scsi/bfa/bfa_fcs.c
> +++ b/drivers/scsi/bfa/bfa_fcs.c
> @@ -761,7 +761,7 @@ bfa_fcs_fabric_psymb_init(struct bfa_fcs_fabric_s *fa=
bric)
>         bfa_ioc_get_adapter_model(&fabric->fcs->bfa->ioc, model);
>
>         /* Model name/number */
> -       strlcpy(port_cfg->sym_name.symname, model,
> +       strscpy(port_cfg->sym_name.symname, model,
>                 BFA_SYMNAME_MAXLEN);
>         strlcat(port_cfg->sym_name.symname, BFA_FCS_PORT_SYMBNAME_SEPARAT=
OR,
>                 BFA_SYMNAME_MAXLEN);
> @@ -822,7 +822,7 @@ bfa_fcs_fabric_nsymb_init(struct bfa_fcs_fabric_s *fa=
bric)
>         bfa_ioc_get_adapter_model(&fabric->fcs->bfa->ioc, model);
>
>         /* Model name/number */
> -       strlcpy(port_cfg->node_sym_name.symname, model,
> +       strscpy(port_cfg->node_sym_name.symname, model,
>                 BFA_SYMNAME_MAXLEN);
>         strlcat(port_cfg->node_sym_name.symname,
>                         BFA_FCS_PORT_SYMBNAME_SEPARATOR,
> diff --git a/drivers/scsi/bfa/bfa_fcs_lport.c b/drivers/scsi/bfa/bfa_fcs_=
lport.c
> index b12afcc4b189..008afd817087 100644
> --- a/drivers/scsi/bfa/bfa_fcs_lport.c
> +++ b/drivers/scsi/bfa/bfa_fcs_lport.c
> @@ -2642,10 +2642,10 @@ bfa_fcs_fdmi_get_hbaattr(struct bfa_fcs_lport_fdm=
i_s *fdmi,
>         bfa_ioc_get_adapter_fw_ver(&port->fcs->bfa->ioc,
>                                         hba_attr->fw_version);
>
> -       strlcpy(hba_attr->driver_version, (char *)driver_info->version,
> +       strscpy(hba_attr->driver_version, (char *)driver_info->version,
>                 sizeof(hba_attr->driver_version));
>
> -       strlcpy(hba_attr->os_name, driver_info->host_os_name,
> +       strscpy(hba_attr->os_name, driver_info->host_os_name,
>                 sizeof(hba_attr->os_name));
>
>         /*
> @@ -2663,13 +2663,13 @@ bfa_fcs_fdmi_get_hbaattr(struct bfa_fcs_lport_fdm=
i_s *fdmi,
>         bfa_fcs_fdmi_get_portattr(fdmi, &fcs_port_attr);
>         hba_attr->max_ct_pyld =3D fcs_port_attr.max_frm_size;
>
> -       strlcpy(hba_attr->node_sym_name.symname,
> +       strscpy(hba_attr->node_sym_name.symname,
>                 port->port_cfg.node_sym_name.symname, BFA_SYMNAME_MAXLEN)=
;
>         strcpy(hba_attr->vendor_info, "QLogic");
>         hba_attr->num_ports =3D
>                 cpu_to_be32(bfa_ioc_get_nports(&port->fcs->bfa->ioc));
>         hba_attr->fabric_name =3D port->fabric->lps->pr_nwwn;
> -       strlcpy(hba_attr->bios_ver, hba_attr->option_rom_ver, BFA_VERSION=
_LEN);
> +       strscpy(hba_attr->bios_ver, hba_attr->option_rom_ver, BFA_VERSION=
_LEN);
>
>  }
>
> @@ -2736,19 +2736,19 @@ bfa_fcs_fdmi_get_portattr(struct bfa_fcs_lport_fd=
mi_s *fdmi,
>         /*
>          * OS device Name
>          */
> -       strlcpy(port_attr->os_device_name, driver_info->os_device_name,
> +       strscpy(port_attr->os_device_name, driver_info->os_device_name,
>                 sizeof(port_attr->os_device_name));
>
>         /*
>          * Host name
>          */
> -       strlcpy(port_attr->host_name, driver_info->host_machine_name,
> +       strscpy(port_attr->host_name, driver_info->host_machine_name,
>                 sizeof(port_attr->host_name));
>
>         port_attr->node_name =3D bfa_fcs_lport_get_nwwn(port);
>         port_attr->port_name =3D bfa_fcs_lport_get_pwwn(port);
>
> -       strlcpy(port_attr->port_sym_name.symname,
> +       strscpy(port_attr->port_sym_name.symname,
>                 bfa_fcs_lport_get_psym_name(port).symname, BFA_SYMNAME_MA=
XLEN);
>         bfa_fcs_lport_get_attr(port, &lport_attr);
>         port_attr->port_type =3D cpu_to_be32(lport_attr.port_type);
> @@ -3229,7 +3229,7 @@ bfa_fcs_lport_ms_gmal_response(void *fcsarg, struct=
 bfa_fcxp_s *fcxp,
>                                         rsp_str[gmal_entry->len-1] =3D 0;
>
>                                 /* copy IP Address to fabric */
> -                               strlcpy(bfa_fcs_lport_get_fabric_ipaddr(p=
ort),
> +                               strscpy(bfa_fcs_lport_get_fabric_ipaddr(p=
ort),
>                                         gmal_entry->ip_addr,
>                                         BFA_FCS_FABRIC_IPADDR_SZ);
>                                 break;
> @@ -4667,7 +4667,7 @@ bfa_fcs_lport_ns_send_rspn_id(void *ns_cbarg, struc=
t bfa_fcxp_s *fcxp_alloced)
>                  * to that of the base port.
>                  */
>
> -               strlcpy(symbl,
> +               strscpy(symbl,
>                         (char *)&(bfa_fcs_lport_get_psym_name
>                          (bfa_fcs_get_base_port(port->fcs))),
>                         sizeof(symbl));
> @@ -5194,7 +5194,7 @@ bfa_fcs_lport_ns_util_send_rspn_id(void *cbarg, str=
uct bfa_fcxp_s *fcxp_alloced)
>                  * For Vports, we append the vport's port symbolic name
>                  * to that of the base port.
>                  */
> -               strlcpy(symbl, (char *)&(bfa_fcs_lport_get_psym_name
> +               strscpy(symbl, (char *)&(bfa_fcs_lport_get_psym_name
>                         (bfa_fcs_get_base_port(port->fcs))),
>                         sizeof(symbl));
>
> diff --git a/drivers/scsi/bfa/bfa_ioc.c b/drivers/scsi/bfa/bfa_ioc.c
> index 5740302d83ac..e1ed1424fddb 100644
> --- a/drivers/scsi/bfa/bfa_ioc.c
> +++ b/drivers/scsi/bfa/bfa_ioc.c
> @@ -2788,7 +2788,7 @@ void
>  bfa_ioc_get_adapter_manufacturer(struct bfa_ioc_s *ioc, char *manufactur=
er)
>  {
>         memset((void *)manufacturer, 0, BFA_ADAPTER_MFG_NAME_LEN);
> -       strlcpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
> +       strscpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
>  }
>
>  void
> diff --git a/drivers/scsi/bfa/bfa_svc.c b/drivers/scsi/bfa/bfa_svc.c
> index 4e3cef02f10f..c9745c0b4eee 100644
> --- a/drivers/scsi/bfa/bfa_svc.c
> +++ b/drivers/scsi/bfa/bfa_svc.c
> @@ -330,7 +330,7 @@ bfa_plog_str(struct bfa_plog_s *plog, enum bfa_plog_m=
id mid,
>                 lp.eid =3D event;
>                 lp.log_type =3D BFA_PL_LOG_TYPE_STRING;
>                 lp.misc =3D misc;
> -               strlcpy(lp.log_entry.string_log, log_str,
> +               strscpy(lp.log_entry.string_log, log_str,
>                         BFA_PL_STRING_LOG_SZ);
>                 lp.log_entry.string_log[BFA_PL_STRING_LOG_SZ - 1] =3D '\0=
';
>                 bfa_plog_add(plog, &lp);
> diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
> index 529b73a83d69..62cb7a864fd5 100644
> --- a/drivers/scsi/bfa/bfad.c
> +++ b/drivers/scsi/bfa/bfad.c
> @@ -965,19 +965,19 @@ bfad_start_ops(struct bfad_s *bfad) {
>
>         /* Fill the driver_info info to fcs*/
>         memset(&driver_info, 0, sizeof(driver_info));
> -       strlcpy(driver_info.version, BFAD_DRIVER_VERSION,
> +       strscpy(driver_info.version, BFAD_DRIVER_VERSION,
>                 sizeof(driver_info.version));
>         if (host_name)
> -               strlcpy(driver_info.host_machine_name, host_name,
> +               strscpy(driver_info.host_machine_name, host_name,
>                         sizeof(driver_info.host_machine_name));
>         if (os_name)
> -               strlcpy(driver_info.host_os_name, os_name,
> +               strscpy(driver_info.host_os_name, os_name,
>                         sizeof(driver_info.host_os_name));
>         if (os_patch)
> -               strlcpy(driver_info.host_os_patch, os_patch,
> +               strscpy(driver_info.host_os_patch, os_patch,
>                         sizeof(driver_info.host_os_patch));
>
> -       strlcpy(driver_info.os_device_name, bfad->pci_name,
> +       strscpy(driver_info.os_device_name, bfad->pci_name,
>                 sizeof(driver_info.os_device_name));
>
>         /* FCS driver info init */
> diff --git a/drivers/scsi/bfa/bfad_attr.c b/drivers/scsi/bfa/bfad_attr.c
> index 5a85401e9e2d..e96e4b6df265 100644
> --- a/drivers/scsi/bfa/bfad_attr.c
> +++ b/drivers/scsi/bfa/bfad_attr.c
> @@ -834,7 +834,7 @@ bfad_im_symbolic_name_show(struct device *dev, struct=
 device_attribute *attr,
>         char symname[BFA_SYMNAME_MAXLEN];
>
>         bfa_fcs_lport_get_attr(&bfad->bfa_fcs.fabric.bport, &port_attr);
> -       strlcpy(symname, port_attr.port_cfg.sym_name.symname,
> +       strscpy(symname, port_attr.port_cfg.sym_name.symname,
>                         BFA_SYMNAME_MAXLEN);
>         return sysfs_emit(buf, "%s\n", symname);
>  }
> diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
> index 79d4f7ee5bcb..520f9152f3bf 100644
> --- a/drivers/scsi/bfa/bfad_bsg.c
> +++ b/drivers/scsi/bfa/bfad_bsg.c
> @@ -119,7 +119,7 @@ bfad_iocmd_ioc_get_attr(struct bfad_s *bfad, void *cm=
d)
>
>         /* fill in driver attr info */
>         strcpy(iocmd->ioc_attr.driver_attr.driver, BFAD_DRIVER_NAME);
> -       strlcpy(iocmd->ioc_attr.driver_attr.driver_ver,
> +       strscpy(iocmd->ioc_attr.driver_attr.driver_ver,
>                 BFAD_DRIVER_VERSION, BFA_VERSION_LEN);
>         strcpy(iocmd->ioc_attr.driver_attr.fw_ver,
>                 iocmd->ioc_attr.adapter_attr.fw_ver);
> @@ -307,7 +307,7 @@ bfad_iocmd_port_get_attr(struct bfad_s *bfad, void *c=
md)
>         iocmd->attr.port_type =3D port_attr.port_type;
>         iocmd->attr.loopback =3D port_attr.loopback;
>         iocmd->attr.authfail =3D port_attr.authfail;
> -       strlcpy(iocmd->attr.port_symname.symname,
> +       strscpy(iocmd->attr.port_symname.symname,
>                 port_attr.port_cfg.sym_name.symname,
>                 sizeof(iocmd->attr.port_symname.symname));
>
> diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
> index c335f7a188d2..a9d3d8562d3c 100644
> --- a/drivers/scsi/bfa/bfad_im.c
> +++ b/drivers/scsi/bfa/bfad_im.c
> @@ -1046,7 +1046,7 @@ bfad_fc_host_init(struct bfad_im_port_s *im_port)
>         /* For fibre channel services type 0x20 */
>         fc_host_supported_fc4s(host)[7] =3D 1;
>
> -       strlcpy(symname, bfad->bfa_fcs.fabric.bport.port_cfg.sym_name.sym=
name,
> +       strscpy(symname, bfad->bfa_fcs.fabric.bport.port_cfg.sym_name.sym=
name,
>                 BFA_SYMNAME_MAXLEN);
>         sprintf(fc_host_symbolic_name(host), "%s", symname);
>
>
